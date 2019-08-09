import './location.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String imageUrl;
  final String originUri;
  Location origin;

  Character({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.imageUrl,
    this.originUri,
    this.origin,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      originUri: json['origin']['url'],
      origin: json['origin'] != null ? Location.fromJson(json['origin']) : null,
      gender: json['gender'],
      imageUrl: json['image'],
    );
  }
}
