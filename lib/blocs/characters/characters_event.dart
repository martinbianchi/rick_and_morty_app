import 'package:meta/meta.dart';

@immutable
abstract class CharactersEvent {}

class FetchCharacters extends CharactersEvent {
  final int id;

  FetchCharacters({this.id});
}
