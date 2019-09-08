import 'package:rick_and_morty_app/models/episode.dart';

import './location.dart';

class Character {
  final String id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String imageUrl;
  final String originUri;
  Location origin;
  Location lastLocation;
  List<Episode> episodes;

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
    this.lastLocation,
    this.episodes,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final episodesListGeneric = json['episodes'] as List ?? null;
    List<Episode> episodesList;

    if (episodesListGeneric != null) {
      episodesList =
          episodesListGeneric.map((e) => Episode.fromJson(e)).toList();
    }
    return Character(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        origin: json['origin'] != null
            ? Location.fromJson(json['origin'])
            : Location(
                name: 'Unknown',
                dimension: 'Unknown',
                type: 'Unkwnown',
              ),
        lastLocation: json['last_location'] != null
            ? Location.fromJson(json['last_location'])
            : Location(
                name: 'Unknown',
                dimension: 'Unknown',
                type: 'Unkwnown',
              ),
        gender: json['gender'],
        imageUrl: json['image'],
        episodes: episodesList);
  }
}
