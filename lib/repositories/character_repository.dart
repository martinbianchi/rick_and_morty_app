import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models/character.dart';

class CharacterRepository {
  static const baseUrl = "https://rickandmortyapi.com/api/character";
  final http.Client httpClient;

  CharacterRepository({@required this.httpClient});

  Future<Character> getOne(int id) async {
    final url = '$baseUrl/$id';

    final response = await http.get(url);
    final characterDecoded = jsonDecode(response.body);

    final Character character = Character.fromJson(characterDecoded);

    return character;
  }

  Future<List<Character>> getAll(int page) async {
    final response = await http.get('$baseUrl/?page=$page');
    final characterDecoded = jsonDecode(response.body);

    final List<Character> character = (characterDecoded["results"] as List).map((c) => Character.fromJson(c)).toList();

    return character;
  }
}
