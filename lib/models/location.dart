class Location {
  final String id;
  final String name;
  final String type;
  final String dimension;

  Location({
    this.id,
    this.name,
    this.type,
    this.dimension,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'] != null ? json['name'] : 'Unknown',
      type: json['type'] != null ? json['type'] : 'Unknown',
      dimension: json['dimension'] != null ? json['dimension'] : 'Unknown',
    );
  }
}
