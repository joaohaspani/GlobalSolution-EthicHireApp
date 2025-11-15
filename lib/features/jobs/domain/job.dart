class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String modality;
  final String description;
  final double matchScore;
  final bool isBlind;
  final List<String> skills;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.modality,
    required this.description,
    required this.matchScore,
    required this.isBlind,
    required this.skills,
  });
}
