import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:rick_and_morty_app/blocs/character/character_bloc.dart';
import 'package:rick_and_morty_app/blocs/characters/characters_event.dart';
import 'package:rick_and_morty_app/screens/character_detail_screen.dart';

import './blocs/characters/characters_bloc.dart';
import './blocs/characters/characters_state.dart';
import './blocs/characters/characters_event.dart';
import './repositories/character_repository.dart';
import './repositories/location_repository.dart';
import './widgets/bottom_loader.dart';
import './widgets/character_card.dart';

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

  @override
  void initState() {
    super.initState();
    _charactersBloc = CharactersBloc(
      characterRepository: widget.characterRepository,
      locationRepository: widget.locationRepository,
    );
    _charactersBloc.dispatch(FetchCharacters(id: 1));
  }

  @override
  Widget build(BuildContext context) {
    int index;

    final appBar = AppBar(
      title: Text('Rick and Morty'),
    );

    return MaterialApp(
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
      home: Scaffold(
        appBar: appBar,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MultiBlocProvider(
              providers: [
                BlocProvider<CharactersBloc>(
                  builder: (ctx) => _charactersBloc,
                ),
              ],
              child: BlocBuilder<CharactersBloc, CharactersState>(
                builder: (context, state) {
                  if (state is CharactersLoaded) {
                    return Column(
                      children: <Widget>[
                        CarouselSlider(
                            initialPage: (state.page - 1) * 19,
                            enableInfiniteScroll: false,
                            onPageChanged: (val) {
                              print(val);
                              index = val;
                              // var modToCompare = (state.page * 19);
                              // var mod = val % 19;
                              if (val == 19) {
                                _charactersBloc.dispatch(
                                  FetchCharacters(
                                    id: (state.page + 1),
                                  ),
                                );
                              }
                            },
                            aspectRatio: 0.63,
                            // height: (MediaQuery.of(context).size.height -
                            //     appBar.preferredSize.height -
                            //     MediaQuery.of(context).padding.top) * 0.9,
                            items: state.characters.map((character) {
                              return Builder(
                                builder: (ctx) {
                                  return index == 19
                                      ? BottomLoader()
                                      : Container(
                                          child: CharacterCard(
                                            character: character,
                                          ),
                                        );
                                },
                              );
                            }).toList()),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      routes: {
        CharacterDetailScreen.routeName: (ctx) => CharacterDetailScreen(characterRepository: widget.characterRepository),
      },
    );
  }
}
