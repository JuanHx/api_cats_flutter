// data/models/breed_model.dart
import '../../domain/entities/breed.dart';

class BreedModel {
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
  final String life_span;

  BreedModel({
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
    required this.life_span,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
      description: json['description'],
      wikipediaUrl: json['wikipedia_url'],
      referenceImageId: json['reference_image_id'],
      adaptability: json['adaptability'] ?? 0,
      affectionLevel: json['affection_level'] ?? 0,
      childFriendly: json['child_friendly'] ?? 0,
      dogFriendly: json['dog_friendly'] ?? 0,
      energyLevel: json['energy_level'] ?? 0,
      grooming: json['grooming'] ?? 0,
      healthIssues: json['health_issues'] ?? 0,
      intelligence: json['intelligence'] ?? 0,
      sheddingLevel: json['shedding_level'] ?? 0,
      socialNeeds: json['social_needs'] ?? 0,
      strangerFriendly: json['stranger_friendly'] ?? 0,
      vocalisation: json['vocalisation'] ?? 0,
      life_span: json['life_span'] ?? '',
    );
  }

  Breed toEntity() {
    return Breed(
      id: id,
      name: name,
      description: description,
      origin: origin,
      wikipediaUrl: wikipediaUrl,
      referenceImageId: referenceImageId,
      adaptability: adaptability,
      affectionLevel: affectionLevel,
      childFriendly: childFriendly,
      dogFriendly: dogFriendly,
      energyLevel: energyLevel,
      grooming: grooming,
      healthIssues: healthIssues,
      intelligence: intelligence,
      sheddingLevel: sheddingLevel,
      socialNeeds: socialNeeds,
      strangerFriendly: strangerFriendly,
      vocalisation: vocalisation,
      lifeSpan: life_span,
    );
  }
}
