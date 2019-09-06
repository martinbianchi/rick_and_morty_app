import '../../models/character.dart';
import '../../models/episode.dart';

abstract class CharacterState {}

class CharacterUnloaded extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final Character character;

  CharacterLoaded({this.character});
}

class CharacterError extends CharacterState {
  final String error;

  CharacterError(this.error);
}