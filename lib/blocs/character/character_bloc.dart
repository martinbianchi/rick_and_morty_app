import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';

import './character_event.dart';
import './character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;

  Map<String, Character> _charactersCached = {};

  CharacterBloc({
    @required this.characterRepository,
  });

  @override
  CharacterState get initialState => CharacterUnloaded();

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if (event is FetchCharacter) {
      try {
        yield CharacterLoading();
        if (_charactersCached.containsKey(event.id)) {
          yield CharacterLoaded(character: _charactersCached[event.id]);
        } else {
          final character = await characterRepository.getOneGraphQL(event.id);
          _charactersCached[event.id] = character;
          yield CharacterLoaded(
            character: character,
          );
        }
      } catch (ex) {
        yield CharacterError(ex);
      }
    }
  }
}
