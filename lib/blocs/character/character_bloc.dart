import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';

import './character_event.dart';
import './character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;

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
        final character = await characterRepository.getOneGraphQL(event.id);
        yield CharacterLoaded(
          character: character,
        );
      } catch (ex) {
        yield CharacterError(ex);
      }
    }
  }
}
