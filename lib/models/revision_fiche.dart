class RevisionFiche {
  const RevisionFiche({
    required this.slug,
    required this.title,
    required this.theme,
    required this.subtitle,
    required this.summary,
    required this.keyPoints,
    required this.sections,
    required this.pitfalls,
    required this.questionCount,
    this.isPremium = false,
  });

  final String slug;
  final String title;
  final String theme;
  final String subtitle;
  final String summary;
  final List<String> keyPoints;
  final List<RevisionContentSection> sections;
  final List<String> pitfalls;
  final int questionCount;
  final bool isPremium;
}

class RevisionContentSection {
  const RevisionContentSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<String> items;
}
