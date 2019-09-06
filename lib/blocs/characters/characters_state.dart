import 'package:meta/meta.dart';
import '../../models/character.dart';

@immutable
abstract class CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  final int page;

  CharactersLoaded({this.characters, this.page});
}

class CharactersLoading extends CharactersState {}

class CharactersUnloaded extends CharactersState {}
