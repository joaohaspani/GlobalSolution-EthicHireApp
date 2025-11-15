    import 'package:flutter/material.dart';
    import 'package:flutter_riverpod/flutter_riverpod.dart';
    import '../../../jobs/presentation/providers/job_providers.dart';

    class DashboardPage extends ConsumerWidget {
      const DashboardPage({super.key});

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        final jobs = ref.watch(jobListProvider);
        final totalJobs = jobs.length;
        final blindJobs = jobs.where((j) => j.isBlind).length;
        final avgMatch = totalJobs == 0
            ? 0.0
            : jobs.map((j) => j.matchScore).reduce((a, b) => a + b) / totalJobs;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Painel de inclusão e desempenho',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Acompanhe indicadores que ajudam a monitorar a eficiência e a ética '
                'dos processos de recrutamento realizados pelo EthicHire.',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      title: 'Vagas ativas',
                      value: '$totalJobs',
                      description:
                          'Quantidade de oportunidades disponíveis na plataforma.',
                      icon: Icons.work_outline,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MetricCard(
                      title: 'Processos cegos',
                      value: '$blindJobs',
                      description:
                          'Vagas que ocultam dados sensíveis nas etapas iniciais.',
                      icon: Icons.visibility_off_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _MetricCard(
                title: 'Match médio dos candidatos',
                value: '${(avgMatch * 100).toStringAsFixed(0)}%',
                description:
                    'Nível médio de aderência entre candidatos e vagas recomendadas.',
                icon: Icons.insights_outlined,
              ),
              const SizedBox(height: 24),
              const Text(
                'Como esse painel apoia decisões éticas?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Permite que empresas monitorem a eficiência e a transparência dos processos.'
                '• Incentiva ajustes em etapas com possíveis riscos de viés.'
                '• Reforça a cultura de recrutamento centrado em pessoas, dados e inclusão.',
              ),
            ],
          ),
        );
      }
    }

    class _MetricCard extends StatelessWidget {
      final String title;
      final String value;
      final String description;
      final IconData icon;

      const _MetricCard({
        required this.title,
        required this.value,
        required this.description,
        required this.icon,
      });

      @override
      Widget build(BuildContext context) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
