import 'package:meta/meta.dart';
import 'package:rick_and_morty_app/blocs/character/character_state.dart';
import '../../models/character.dart';

@immutable
abstract class CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  final bool isLastPage;

  CharactersLoaded({this.characters, this.isLastPage});
}

class CharactersLoading extends CharactersState {}

class CharactersUnloaded extends CharactersState {}

class CharactersSearchedLoaded extends CharacterState{
  final List<Character> characters;

  CharactersSearchedLoaded({this.characters});
}
