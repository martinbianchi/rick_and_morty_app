
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:rick_and_morty_app/blocs/character/character_bloc.dart';
import 'package:rick_and_morty_app/blocs/characters/characters_event.dart';
import 'package:rick_and_morty_app/screens/character_detail_screen.dart';
import 'package:rick_and_morty_app/screens/characters_screen.dart';

import './blocs/characters/characters_bloc.dart';
import './blocs/characters/characters_event.dart';
import './repositories/character_repository.dart';
import './repositories/location_repository.dart';

void main() {
  final CharacterRepository characterRepository =
      CharacterRepository(httpClient: http.Client());
  final LocationRepository locationRepository =
      LocationRepository(httpClient: http.Client());
  runApp(MyApp(
    characterRepository: characterRepository,
    locationRepository: locationRepository,
  ));
}

class MyApp extends StatefulWidget {
  final CharacterRepository characterRepository;
  final LocationRepository locationRepository;

  MyApp({this.characterRepository, this.locationRepository});
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CharactersBloc _charactersBloc;
  CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _charactersBloc = CharactersBloc(
      characterRepository: widget.characterRepository,
      locationRepository: widget.locationRepository,
    );
    _characterBloc = CharacterBloc(
      characterRepository: widget.characterRepository,
    );
    _charactersBloc.dispatch(FetchCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharactersBloc>(
          builder: (ctx) => _charactersBloc,
        ),
        BlocProvider<CharacterBloc>(
          builder: (ctx) => _characterBloc,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.teal,
            // accentColor: Colors.tealAccent,
            iconTheme: IconThemeData(color: Colors.tealAccent),
            textTheme: TextTheme(
              title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              body1: TextStyle(
                fontSize: 14.0,
              ),
            ),
            fontFamily: 'Blinker'),
        home: CharactersScreen(),
        routes: {
          CharacterDetailScreen.routeName: (ctx) => CharacterDetailScreen(
              characterRepository: widget.characterRepository),
        },
      ),
    );
  }
}
