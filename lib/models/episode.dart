class Episode {
  final String id;
  final String name;
  final String airDate;
  final String episode;

  Episode({
    this.id,
    this.name,
    this.airDate,
    this.episode,
  });

    factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
    );
  }
}
