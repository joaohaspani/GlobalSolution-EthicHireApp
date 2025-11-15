import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/job.dart';

final jobListProvider = Provider<List<Job>>((ref) {
  return const [
    Job(
      id: '1',
      title: 'Analista de Dados Pleno',
      company: 'Tech4All - Parceira EthicHire',
      location: 'Remoto - Brasil',
      modality: 'Remoto',
      description:
          'Atuação em projetos de dados com foco em inclusão e diversidade, '
          'apoiando decisões éticas em recrutamento.',
      matchScore: 0.86,
      isBlind: true,
      skills: ['SQL', 'Power BI', 'Python', 'Comunicação'],
    ),
    Job(
      id: '2',
      title: 'Desenvolvedor Flutter Júnior',
      company: 'FutureJobs - Parceira EthicHire',
      location: 'São Paulo - SP',
      modality: 'Híbrido',
      description:
          'Desenvolvimento de aplicativos inclusivos e acessíveis, '
          'participando de squads focados em experiência do candidato.',
      matchScore: 0.78,
      isBlind: true,
      skills: ['Flutter', 'Dart', 'Git', 'Trabalho em equipe'],
    ),
    Job(
      id: '3',
      title: 'Especialista em Diversidade & Inclusão',
      company: 'PeopleFirst Consulting',
      location: 'Remoto - Brasil',
      modality: 'Remoto',
      description:
          'Construção de programas de diversidade, acompanhamento de métricas '
          'e apoio a lideranças na criação de ambientes mais inclusivos.',
      matchScore: 0.92,
      isBlind: true,
      skills: ['D&I', 'Comunicação', 'Análise de dados', 'Facilitação'],
    ),
  ];
});
