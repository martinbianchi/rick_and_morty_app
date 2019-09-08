import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/models/pagination.dart';

class CharactersResponse {
  final List<Character> characters;
  final Pagination pagination;

  CharactersResponse({
    this.characters,
    this.pagination,
  });
}
