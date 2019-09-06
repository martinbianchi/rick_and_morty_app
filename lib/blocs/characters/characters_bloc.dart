import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/models/location.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/repositories/location_repository.dart';
import './characters_event.dart';
import './characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository characterRepository;
  final LocationRepository locationRepository;

  CharactersBloc({this.characterRepository, this.locationRepository});

  @override
  CharactersState get initialState => CharactersUnloaded();

  @override
  Stream<CharactersState> mapEventToState(
    CharactersEvent event,
  ) async* {
    if (event is FetchCharacters) {
      final oldCharacters = (currentState is CharactersLoaded) ? (currentState as CharactersLoaded).characters : [];
      List<Character> characters = await characterRepository.getAll(event.id);

       characters.forEach((character) async {
        if (character.originUri != '' && character.originUri != null) {
          // final location =
          //     await locationRepository.getByUri(character.originUri);
          // character.origin = location;
        } else {
          character.origin = Location(
            dimension: 'Unknown',
            name: 'Unknown',
            type: 'Unknown',
          );
        }
      });
      if(event.id > 1){
        characters = [...oldCharacters, ...characters];
      }
      yield (CharactersLoaded(characters: characters, page: event.id));
    }
  }
}
