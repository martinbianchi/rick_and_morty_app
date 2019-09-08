import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_app/models/characters_response.dart';

import '../../models/character.dart';
import '../../models/pagination.dart';
import '../../repositories/character_repository.dart';
import '../../repositories/location_repository.dart';
import './characters_event.dart';
import './characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository characterRepository;
  final LocationRepository locationRepository;

  List<Character> _charactersCached = [];
  List<Character> _filteredCharacters = [];

  bool _isSearching = false;
  String _textSearched = '';

  Pagination _currentCharactersPagination =
      Pagination(currentPage: 0, maxPages: 1);
  Pagination _fileterdCharactersPagination =
      Pagination(currentPage: 0, maxPages: 1);

  CharactersBloc({this.characterRepository, this.locationRepository});

  @override
  CharactersState get initialState => CharactersUnloaded();

  @override
  Stream<CharactersState> mapEventToState(
    CharactersEvent event,
  ) async* {
    if (event is FetchCharacters) {
      if (_isSearching) {
        if (_fileterdCharactersPagination.currentPage >=
            _fileterdCharactersPagination.maxPages) {
          yield CharactersLoaded(
              characters: _filteredCharacters, isLastPage: true);
        } else {
          final nextPage = _fileterdCharactersPagination.currentPage + 1;
          final charactersResponse =
              await characterRepository.getByName(_textSearched, nextPage);

          _filteredCharacters = [
            ..._filteredCharacters,
            ...charactersResponse.characters
          ];
          _fileterdCharactersPagination = charactersResponse.pagination;

          yield CharactersLoaded(
              characters: _filteredCharacters, isLastPage: false);
        }
      } else {
        final List<Character> oldCharacters = (currentState is CharactersLoaded)
            ? (currentState as CharactersLoaded).characters
            : [];
        if (_currentCharactersPagination.currentPage >=
            _currentCharactersPagination.maxPages) {
          yield CharactersLoaded(characters: oldCharacters, isLastPage: true);
        } else {
          final nextPage = _currentCharactersPagination.currentPage + 1;
          CharactersResponse charactersResponse =
              await characterRepository.getAll(nextPage);

          _charactersCached = [
            ..._charactersCached,
            ...charactersResponse.characters
          ];
          _currentCharactersPagination = charactersResponse.pagination;

          yield (CharactersLoaded(
              characters: _charactersCached, isLastPage: false));
        }
      }
    }

    if (event is SearchCharacters) {
      if (event.searchText != _textSearched) {
        _fileterdCharactersPagination = Pagination(currentPage: 0, maxPages: 1);
        _filteredCharacters = [];
      }
      _isSearching = true;
      yield CharactersLoading();
      if (_fileterdCharactersPagination.currentPage >=
          _fileterdCharactersPagination.maxPages) {
        yield CharactersLoaded(
            characters: _filteredCharacters, isLastPage: true);
      } else {
        final nextPage = _fileterdCharactersPagination.currentPage + 1;
        final charactersResponse =
            await characterRepository.getByName(event.searchText, nextPage);

        _textSearched = event.searchText;

        _filteredCharacters = [
          ..._filteredCharacters,
          ...charactersResponse.characters
        ];
        _fileterdCharactersPagination = charactersResponse.pagination;

        yield CharactersLoaded(
            characters: _filteredCharacters, isLastPage: false);
      }
    }

    if (event is CancelSearch) {
      _fileterdCharactersPagination = Pagination(currentPage: 0, maxPages: 1);
      _filteredCharacters = [];
      _textSearched = '';
      _isSearching = false;

      yield (CharactersLoaded(characters: _charactersCached));
    }
  }
}
