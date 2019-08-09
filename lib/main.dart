import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/blocs/character_bloc.dart';
import 'package:rick_and_morty_app/blocs/character_state.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/repositories/location_repository.dart';
import 'package:rick_and_morty_app/widgets/bottom_loader.dart';
import 'package:rick_and_morty_app/widgets/character_card.dart';
import 'package:http/http.dart' as http;

import 'package:carousel_slider/carousel_slider.dart';

import 'blocs/character_event.dart';

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
  CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _characterBloc = CharacterBloc(
      characterRepository: widget.characterRepository,
      locationRepository: widget.locationRepository,
    );
    _characterBloc.dispatch(FetchCharacter(id: 1));
  }

  @override
  Widget build(BuildContext context) {
    int index;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            body1: TextStyle(
              fontSize: 14.0,
            ),
          ),
          fontFamily: 'Blinker'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rick and Morty'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Text(
                'The Rick and Morty Library',
                style: TextStyle(fontSize: 28.0),
              ),
            ),
            BlocProvider(
              builder: (ctx) => _characterBloc,
              child: BlocBuilder<CharacterBloc, CharacterState>(
                builder: (context, state) {
                  if (state is CharacterLoaded) {
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
                                _characterBloc.dispatch(
                                  FetchCharacter(
                                    id: (state.page + 1),
                                  ),
                                );
                              }
                            },
                            height: 520,
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
    );
  }
}
