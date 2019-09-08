import 'package:meta/meta.dart';

@immutable
abstract class CharactersEvent {}

class FetchCharacters extends CharactersEvent { }

class SearchCharacters extends CharactersEvent {
  final String searchText;

  SearchCharacters({this.searchText});
}

class CancelSearch extends CharactersEvent {}
