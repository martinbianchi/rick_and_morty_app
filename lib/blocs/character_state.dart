import 'package:meta/meta.dart';
import '../models/character.dart';

@immutable
abstract class CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;
  final int page;

  CharacterLoaded({this.characters, this.page});
}

class CharacterLoading extends CharacterState {}

class CharacterUnloaded extends CharacterState {}
