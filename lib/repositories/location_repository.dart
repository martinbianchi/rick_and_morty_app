import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/location.dart';

class LocationRepository {
  static const baseUrl = "https://rickandmortyapi.com/api/character";
  final http.Client httpClient;

  LocationRepository({@required this.httpClient});

  Future<Location> getOne(int id) async {
    final url = '$baseUrl/$id';

    final response = await http.get(url);
    final locationDecoded = jsonDecode(response.body);

    final Location location = Location.fromJson(locationDecoded);

    return location;
  }

  Future<Location> getByUri(String uri) async {
    final response = await http.get(uri);
    final locationDecoded = jsonDecode(response.body);

    final Location location = Location.fromJson(locationDecoded);

    return location;
  }
}
