# 💼 EthicHire – Plataforma de Recrutamento Ético e Inclusivo

O **EthicHire** é um aplicativo desenvolvido em **Flutter** cujo objetivo é promover **processos seletivos mais justos, inclusivos e livres de vieses**.  
Ele conecta candidatos e empresas por meio de **vagas cegas**, **match ético**, **painel de inclusão**, e uma interface moderna baseada em acessibilidade e boas práticas de UX.

A solução foi criada como parte da **Global Solution – O Futuro do Trabalho**, com foco em tecnologia, impacto social e equidade no mercado de trabalho.

---

## 🧭 Storytelling da Startup

A EthicHire nasceu da necessidade de transformar a forma como empresas contratam e como candidatos são avaliados.  
Em um cenário onde vieses inconscientes impedem oportunidades para muitos talentos, decidimos criar uma plataforma que:

✨ Valoriza competências acima de aparências  
✨ Ajuda empresas a praticar recrutamento ético  
✨ Apoia candidatos que buscam **igualdade de oportunidade**

Nós acreditamos que **diversidade, inclusão e transparência** não são tendências — são pilares fundamentais para um futuro sustentável no mundo do trabalho.

---

## 📱 Funcionalidades Principais

### ✔️ Vagas Cegas (Blind Hiring)
- Oculte dados sensíveis (nome, foto, idade, gênero, endereço).
- Avaliação focada em competências reais.
- Cards com match, localização e modalidade.

### ✔️ Match Ético
- Algoritmo baseado em:
    - Habilidades técnicas
    - Competências comportamentais
    - Aderência cultural
- Sem uso de informações pessoais sensíveis.

### ✔️ Painel de Inclusão e Desempenho
Indicadores para empresas:
- Vagas ativas
- Processos cegos
- Match médio
- Pontos de risco de viés
- Indicadores de transparência

### ✔️ Perfil Inclusivo
- Exibe competências e trajetória
- Protege dados sensíveis nas etapas iniciais

### ✔️ Landing Page Inicial
Com propósito, missão e rota para navegar ao app.

---

## 🏗 Arquitetura do Projeto

```
lib/
 ├─ core/
 │   └─ theme/
 │        └─ app_theme.dart
 │
 ├─ features/
 │   ├─ home/
 │   │    └─ landing_page.dart
 │   │
 │   ├─ jobs/
 │   │    ├─ domain/job.dart
 │   │    ├─ providers/job_providers.dart
 │   │    └─ pages/jobs_page.dart
 │   │
 │   ├─ dashboard/
 │   │    └─ pages/dashboard_page.dart
 │   │
 │   └─ profile/
 │        └─ pages/profile_page.dart
 │
 ├─ app.dart
 └─ main.dart
```

---

## 🎨 Identidade Visual

Paleta exclusiva:

| Elemento | Cor |
|---------|-----|
| Verde primário | `#1B8E5A` |
| Verde secundário | `#49BF85` |
| Preto suave | `#1A1A1A` |
| Branco | `#FFFFFF` |
| Cinza claro | `#F4F7F5` |

---

## 🧠 Gerenciamento de Memória (Exigência Técnica)

O aplicativo utiliza:

- Widgets `const` para minimizar rebuilds
- Controllers descartados em `dispose()`
- Lógica de negócio fora de `build()`
- Paginação com `ListView.builder`
- Gerenciamento de estado com **Riverpod**
- Temas reaproveitados para evitar reprocessamento

---

## 🗃️ Modelagem de Dados (DER/MER)

### Entidades
- USUARIO
- CANDIDATO
- EMPRESA
- VAGA
- CANDIDATURA
- COMPETENCIA
- VAGA_COMPETENCIA
- CANDIDATO_COMPETENCIA
- FEEDBACK
- LOG_USO

### Relacionamentos
- 1–1 usuário/candidato
- 1–N empresa/vaga
- 1–N/N–1 candidaturas
- N–M competências
- 1–N feedback
- 1–N log_uso

---

## 🛢 Automação PL/SQL

### Trigger de log
```sql
CREATE OR REPLACE TRIGGER trg_log_candidatura
AFTER INSERT ON candidatura
FOR EACH ROW
BEGIN
  INSERT INTO log_uso (id_usuario, acao, data_hora, id_vaga, id_candidatura)
  VALUES (:NEW.id_usuario, 'CANDIDATURA_CRIADA', SYSDATE, :NEW.id_vaga, :NEW.id_candidatura);
END;
/
```

### Métrica de vaga
```sql
CREATE OR REPLACE PROCEDURE prc_atualiza_metricas_vaga(p_id_vaga NUMBER) AS
BEGIN
  UPDATE vaga
  SET total_candidaturas = (
    SELECT COUNT(*) FROM candidatura WHERE id_vaga = p_id_vaga
  )
  WHERE id_vaga = p_id_vaga;
END;
/
```

### Análise de inclusão
```sql
CREATE OR REPLACE PROCEDURE prc_analisa_inclusao IS
BEGIN
  INSERT INTO historico_inclusao (data_registro, media_match, processos_cegos)
  SELECT SYSDATE,
         AVG(match_score),
         COUNT(*) 
  FROM vaga WHERE is_cego = 1;
END;
/
```

---

## ⚙️ Tecnologias Utilizadas

- Flutter (Dart)
- Android Studio
- Material Design 3
- Riverpod
- flutter_local_notifications
- Oracle & PL/SQL

---

## 🏃 Como Executar

### Pré-requisitos
- Flutter SDK
- Android Studio
- Git

### Execução
```bash
git clone https://github.com/joaohaspani/GlobalSolution-EthicHireApp.git
cd ethic_hire
flutter pub get
flutter run
```

---

## 🧪 Testes

Para rodar:

```bash
flutter test
```

Inclui testes de:

- Renderização da Landing Page
- Navegação
- Verificação das abas principais

---



## 🎯 Conclusão

O **EthicHire** entrega uma solução tecnológica com impacto real no futuro do trabalho, promovendo:

- Inclusão
- Transparência
- Equidade
- Decisões baseadas em competências

Inovação com propósito — esse é o EthicHire.
