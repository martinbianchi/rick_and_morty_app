import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/models/location.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/repositories/location_repository.dart';
import './character_event.dart';
import './character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;
  final LocationRepository locationRepository;

  CharacterBloc({this.characterRepository, this.locationRepository});

  @override
  CharacterState get initialState => CharacterUnloaded();

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if (event is FetchCharacter) {
      final oldCharacters = (currentState is CharacterLoaded) ? (currentState as CharacterLoaded).characters : [];
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
      yield (CharacterLoaded(characters: characters, page: event.id));
    }
  }
}
