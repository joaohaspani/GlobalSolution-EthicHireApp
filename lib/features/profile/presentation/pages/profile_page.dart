    import 'package:flutter/material.dart';

    class ProfilePage extends StatelessWidget {
      const ProfilePage({super.key});

      @override
      Widget build(BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seu perfil inclusivo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Aqui o foco está nas suas competências, experiências e potencial — '
                'não em estereótipos ou dados sensíveis.',
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Resumo profissional',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Profissional em desenvolvimento, em busca de oportunidades em ambientes '
                        'que valorizam diversidade, aprendizado contínuo e impacto positivo.',
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Principais competências',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('• Tecnologias: Flutter, Dart, APIs REST, Git'),
                      Text('• Dados: SQL, análise exploratória, visualização de dados'),
                      Text('• Comportamentais: colaboração, empatia, pensamento analítico'),
                      SizedBox(height: 16),
                      Text(
                        'Preferências de trabalho',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('• Modelo: remoto ou híbrido'),
                      Text('• Cultura: foco em inclusão, respeito e desenvolvimento de pessoas'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Como o EthicHire usa seu perfil?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Seus dados sensíveis são ocultados nas etapas iniciais dos processos.'
                '• O algoritmo destaca competências e experiências relevantes para cada vaga.'
                '• Você recebe recomendações alinhadas aos seus valores e preferências.',
              ),
            ],
          ),
        );
      }
    }
