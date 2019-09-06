import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/models/episode.dart';

class CharacterRepository {
  static const baseUrl = "https://rickandmortyapi.com/api/character";
  static const graphQLUrl = 'https://rickandmortyapi.com/graphql';
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

    final List<Character> character = (characterDecoded["results"] as List)
        .map((c) => Character.fromJson(c))
        .toList();

    return character;
  }

  Future<Character> getOneGraphQL(int id) async {
    final String getCharacterQuery = ''' 
    {
      character(id: "$id"){
        name
        status
        species
        type
        gender
        origin{
          id
          name
          type
          dimension
        }
        last_location: location{
          id
          name
          type
          dimension
        }
        image
        episodes: episode{
          id
          name
          air_date
          episode
        }
      }
    }
    ''';

    final getCharacterReponse = await makeCall(getCharacterQuery);
    final Character character = Character.fromJson(getCharacterReponse['character']);

    return character;
  }

  makeCall(String query) async {
    Map<String, String> body = {"query": query};
    final response =
        await http.post(graphQLUrl, body: json.encode(body), headers: {
      "content-type": "application/json",
    });

    return json.decode(response.body)["data"];
  }
}
