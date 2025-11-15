------------------------------------------------------------
-- 1) CRIACAO DAS TABELAS PRINCIPAIS
------------------------------------------------------------

-- USUARIO (tabela base)
CREATE TABLE usuario (
    id_usuario      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR2(200),
    email           VARCHAR2(200),
    tipo_perfil     VARCHAR2(20)  -- 'CANDIDATO' ou 'EMPRESA'
);

-- EMPRESA (vinculada ao usuário)
CREATE TABLE empresa (
    id_empresa   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario   NUMBER NOT NULL,
    nome         VARCHAR2(200),
    descricao    VARCHAR2(500),
    CONSTRAINT fk_empresa_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

-- CANDIDATO (vinculado ao usuário)
CREATE TABLE candidato (
    id_candidato NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario   NUMBER NOT NULL,
    resumo       VARCHAR2(2000),
    preferencias VARCHAR2(500),
    CONSTRAINT fk_candidato_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

-- VAGA
CREATE TABLE vaga (
    id_vaga        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_empresa     NUMBER NOT NULL,
    titulo         VARCHAR2(200),
    descricao      VARCHAR2(2000),
    localizacao    VARCHAR2(200),
    modalidade     VARCHAR2(100),      -- Remoto, Híbrido, Presencial
    is_cego        NUMBER(1) DEFAULT 1, -- 1 = processo cego
    data_publicacao DATE DEFAULT SYSDATE,
    CONSTRAINT fk_vaga_empresa FOREIGN KEY (id_empresa)
        REFERENCES empresa(id_empresa)
);

-- CANDIDATURA
CREATE TABLE candidatura (
    id_candidatura NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_vaga        NUMBER NOT NULL,
    id_candidato   NUMBER NOT NULL,
    id_usuario     NUMBER NOT NULL,
    status         VARCHAR2(20),      -- EM_ANALISE, APROVADO, REPROVADO
    match_score    NUMBER(5,2),
    data_candidatura DATE DEFAULT SYSDATE,
    CONSTRAINT fk_cand_vaga FOREIGN KEY (id_vaga)
        REFERENCES vaga(id_vaga),
    CONSTRAINT fk_cand_cand FOREIGN KEY (id_candidato)
        REFERENCES candidato(id_candidato),
    CONSTRAINT fk_cand_user FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

------------------------------------------------------------
-- 2) TABELAS DE LOGS E MÉTRICAS
------------------------------------------------------------

-- LOG DE USO DO APLICATIVO
CREATE TABLE log_uso (
    id_log           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario       NUMBER NOT NULL,
    id_vaga          NUMBER NULL,
    id_candidatura   NUMBER NULL,
    acao             VARCHAR2(50) NOT NULL,
    detalhe          VARCHAR2(4000),
    data_hora        TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_log_user FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

-- METRICAS POR VAGA
CREATE TABLE metrica_vaga (
    id_vaga                 NUMBER PRIMARY KEY,
    total_candidaturas      NUMBER DEFAULT 0,
    total_aprovados         NUMBER DEFAULT 0,
    total_reprovados        NUMBER DEFAULT 0,
    taxa_aprovacao          NUMBER(5,2),
    data_ultima_atualizacao TIMESTAMP,
    CONSTRAINT fk_metrica_vaga FOREIGN KEY (id_vaga)
        REFERENCES vaga(id_vaga)
);

-- HISTÓRICO GLOBAL DE INCLUSÃO
CREATE TABLE historico_inclusao (
    id_registro        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_referencia    DATE NOT NULL,
    total_vagas        NUMBER NOT NULL,
    total_vagas_cegas  NUMBER NOT NULL,
    match_medio        NUMBER(5,2),
    processos_cegos    NUMBER,
    data_execucao      TIMESTAMP DEFAULT SYSTIMESTAMP
);

------------------------------------------------------------
-- 3) PROCEDURES DO ETHICHIRE
------------------------------------------------------------

-- Procedure para registro de uso
CREATE OR REPLACE PROCEDURE prc_registra_uso (
    p_id_usuario     IN log_uso.id_usuario%TYPE,
    p_acao           IN log_uso.acao%TYPE,
    p_detalhe        IN log_uso.detalhe%TYPE DEFAULT NULL,
    p_id_vaga        IN log_uso.id_vaga%TYPE DEFAULT NULL,
    p_id_candidatura IN log_uso.id_candidatura%TYPE DEFAULT NULL
) AS
BEGIN
    INSERT INTO log_uso (
        id_usuario,
        id_vaga,
        id_candidatura,
        acao,
        detalhe,
        data_hora
    ) VALUES (
        p_id_usuario,
        p_id_vaga,
        p_id_candidatura,
        p_acao,
        p_detalhe,
        SYSTIMESTAMP
    );
END;
/

-- Procedure para atualização de métricas por vaga
CREATE OR REPLACE PROCEDURE prc_atualiza_metricas_vaga (
    p_id_vaga IN metrica_vaga.id_vaga%TYPE
) AS
    v_total_candidaturas NUMBER;
    v_total_aprovados    NUMBER;
    v_total_reprovados   NUMBER;
    v_taxa_aprovacao     NUMBER(5,2);
BEGIN
    SELECT COUNT(*) INTO v_total_candidaturas
      FROM candidatura
     WHERE id_vaga = p_id_vaga;

    SELECT COUNT(*) INTO v_total_aprovados
      FROM candidatura
     WHERE id_vaga = p_id_vaga
       AND UPPER(status) = 'APROVADO';

    SELECT COUNT(*) INTO v_total_reprovados
      FROM candidatura
     WHERE id_vvaga = p_id_vaga
       AND UPPER(status) = 'REPROVADO';

    IF v_total_candidaturas > 0 THEN
        v_taxa_aprovacao := (v_total_aprovados / v_total_candidaturas) * 100;
    ELSE
        v_taxa_aprovacao := 0;
    END IF;

    MERGE INTO metrica_vaga mv
    USING (SELECT p_id_vaga AS id_vaga FROM dual) src
       ON (mv.id_vaga = src.id_vaga)
    WHEN MATCHED THEN
        UPDATE SET
            total_candidaturas      = v_total_candidaturas,
            total_aprovados         = v_total_aprovados,
            total_reprovados        = v_total_reprovados,
            taxa_aprovacao          = v_taxa_aprovacao,
            data_ultima_atualizacao = SYSTIMESTAMP
    WHEN NOT MATCHED THEN
        INSERT (
            id_vaga,
            total_candidaturas,
            total_aprovados,
            total_reprovados,
            taxa_aprovacao,
            data_ultima_atualizacao
        ) VALUES (
            p_id_vaga,
            v_total_candidaturas,
            v_total_aprovados,
            v_total_reprovados,
            v_taxa_aprovacao,
            SYSTIMESTAMP
        );
END;
/

-- Procedure para gerar histórico global do EthicHire
CREATE OR REPLACE PROCEDURE prc_gera_historico_inclusao AS
    v_total_vagas       NUMBER;
    v_total_vagas_cegas NUMBER;
    v_match_medio       NUMBER(5,2);
    v_processos_cegos   NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total_vagas FROM vaga;

    SELECT COUNT(*) INTO v_total_vagas_cegas
      FROM vaga
     WHERE is_cego = 1;

    SELECT CASE WHEN COUNT(*) > 0
                THEN AVG(match_score)
                ELSE 0
           END
      INTO v_match_medio
      FROM candidatura;

    SELECT COUNT(*)
      INTO v_processos_cegos
      FROM candidatura c
      JOIN vaga v ON v.id_vaga = c.id_vaga
     WHERE v.is_cego = 1;

    INSERT INTO historico_inclusao (
        data_referencia,
        total_vagas,
        total_vagas_cegas,
        match_medio,
        processos_cegos
    ) VALUES (
        TRUNC(SYSDATE),
        v_total_vagas,
        v_total_vagas_cegas,
        v_match_medio,
        v_processos_cegos
    );
END;
/

------------------------------------------------------------
-- 4) TRIGGERS DO ETHICHIRE
------------------------------------------------------------

-- Trigger que registra log de criação de candidatura
CREATE OR REPLACE TRIGGER trg_log_candidatura
AFTER INSERT ON candidatura
FOR EACH ROW
BEGIN
    prc_registra_uso(
        p_id_usuario     => :NEW.id_usuario,
        p_acao           => 'CANDIDATURA_CRIADA',
        p_detalhe        => 'Candidatura criada na vaga ' || :NEW.id_vaga,
        p_id_vaga        => :NEW.id_vaga,
        p_id_candidatura => :NEW.id_candidatura
    );
END;
/

-- Trigger para atualizar métricas quando candidatura é criada ou altera status
CREATE OR REPLACE TRIGGER trg_metrica_vaga_candidatura
AFTER INSERT OR UPDATE OF status ON candidatura
FOR EACH ROW
BEGIN
    prc_atualiza_metricas_vaga(:NEW.id_vaga);
END;
/

------------------------------------------------------------
-- 5) AGENDAMENTO (Opcional)
------------------------------------------------------------

BEGIN
    DBMS_SCHEDULER.create_job (
        job_name        => 'JOB_HISTORICO_INCLUSAO_ETHICHIRE',
        job_type        => 'STORED_PROCEDURE',
        job_action      => 'PRC_GERA_HISTORICO_INCLUSAO',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY;BYHOUR=2;BYMINUTE=0;BYSECOND=0',
        enabled         => TRUE,
        comments        => 'Snapshot diário das métricas de inclusão do EthicHire.'
    );
END;
/
