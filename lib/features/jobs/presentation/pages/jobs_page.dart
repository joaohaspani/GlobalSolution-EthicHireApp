import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/job.dart';
import '../providers/job_providers.dart';

class JobsPage extends ConsumerWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobListProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vagas cegas recomendadas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Os processos abaixo ocultam dados sensíveis do candidato nas etapas iniciais, '
            'garantindo um recrutamento mais ético e inclusivo.',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: jobs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final job = jobs[index];
                return _JobCard(job: job);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Job job;

  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    final matchPercent = (job.matchScore * 100).toStringAsFixed(0);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => JobDetailPage(job: job),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.company,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                        ),
                        child: Text(
                          'Match ${matchPercent}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (job.isBlind)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Processo cego',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    job.location,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.laptop_mac, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    job.modality,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobDetailPage extends StatelessWidget {
  final Job job;

  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final matchPercent = (job.matchScore * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da vaga'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              job.company,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white24,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Chip(
                  label: Text('Match ${matchPercent}%'),
                ),
                const SizedBox(width: 8),
                if (job.isBlind)
                  const Chip(
                    avatar: Icon(Icons.remove_red_eye_outlined, size: 16),
                    label: Text('Processo cego e ético'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                const SizedBox(width: 4),
                Text(job.location),
                const SizedBox(width: 16),
                const Icon(Icons.laptop_mac, size: 16),
                const SizedBox(width: 4),
                Text(job.modality),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Sobre a oportunidade',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(job.description),
            const SizedBox(height: 24),
            const Text(
              'Principais competências',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: job.skills
                  .map(
                    (skill) => Chip(
                      label: Text(skill),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Candidatar-se de forma ética'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Candidatura enviada! Seus dados sensíveis serão protegidos '
                        'nas primeiras etapas do processo.',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
