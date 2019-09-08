
abstract class CharacterEvent {}

class FetchCharacter extends CharacterEvent{
  final String id;

  FetchCharacter(this.id);
}
