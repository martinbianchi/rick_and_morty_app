import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/models/characters_response.dart';
import 'package:rick_and_morty_app/models/pagination.dart';

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

  Future<CharactersResponse> getAll(int page) async {
    final String getCharactersQuery = '''
      {
        characters(page: $page){
          results{
            id
            name
            status
            species
            type
            gender
            image
          }
          info{
            pages
          }
        }
      }
    ''';

    final getCharacterReponse = await makeCall(getCharactersQuery);
    final List<Character> characters =
        (getCharacterReponse["characters"]["results"] as List)
            .map((c) => Character.fromJson(c))
            .toList();

    final Pagination pagination = Pagination(
        maxPages: getCharacterReponse["characters"]["info"]["pages"],
        currentPage: page);

    final CharactersResponse charactersResponse = CharactersResponse(
      characters: characters,
      pagination: pagination,
    );

    return charactersResponse;
  }

  Future<CharactersResponse> getByName(String searchText, int page) async {
    final String getCharactersByNameQuery = '''
      {
        characters(filter: {name: "$searchText"}, page:$page){
          results{
            id
            name
            status
            species
            type
            gender
            image
          }
          info{
            pages
          }
        }
      }
      ''';

    final getCharacterReponse = await makeCall(getCharactersByNameQuery);
    final List<Character> characters =
        (getCharacterReponse["characters"]["results"] as List)
            .map((c) => Character.fromJson(c))
            .toList();

    final Pagination pagination = Pagination(
        maxPages: getCharacterReponse["characters"]["info"]["pages"],
        currentPage: page);

    final CharactersResponse charactersResponse = CharactersResponse(
      characters: characters,
      pagination: pagination,
    );

    return charactersResponse;
  }

  Future<Character> getOneGraphQL(String id) async {
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
    final Character character =
        Character.fromJson(getCharacterReponse['character']);

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
