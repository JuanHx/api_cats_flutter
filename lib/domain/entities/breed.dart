class Breed {
  final String id;
  final String name;
  final String? origin;
  final String description;
  final String? wikipediaUrl;
  final String? referenceImageId;

  final int adaptability;
  final int affectionLevel;
  final int childFriendly;
  final int dogFriendly;
  final int energyLevel;
  final int grooming;
  final int healthIssues;
  final int intelligence;
  final int sheddingLevel;
  final int socialNeeds;
  final int strangerFriendly;
  final int vocalisation;
  final String lifeSpan;

  const Breed({
    required this.id,
    required this.name,
    required this.description,
    this.origin,
    this.wikipediaUrl,
    this.referenceImageId,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.grooming,
    required this.healthIssues,
    required this.intelligence,
    required this.sheddingLevel,
    required this.socialNeeds,
    required this.strangerFriendly,
    required this.vocalisation,
    required this.lifeSpan,
  });
}
