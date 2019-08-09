import 'package:meta/meta.dart';

@immutable
abstract class CharacterEvent {}

class FetchCharacter extends CharacterEvent {
  final int id;

  FetchCharacter({this.id});
}
