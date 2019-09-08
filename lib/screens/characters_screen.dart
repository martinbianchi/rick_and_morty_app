import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/blocs/characters/characters_bloc.dart';
import 'package:rick_and_morty_app/blocs/characters/characters_event.dart';
import 'package:rick_and_morty_app/blocs/characters/characters_state.dart';
import 'package:rick_and_morty_app/widgets/bottom_loader.dart';
import 'package:rick_and_morty_app/widgets/character_card.dart';
import 'package:rick_and_morty_app/widgets/search_bar.dart';

class CharactersScreen extends StatelessWidget {


  Widget build(BuildContext context) {
    int index;
    CharactersBloc _charactersBloc = BlocProvider.of<CharactersBloc>(context);

    return Scaffold(
      appBar: PreferredSize(
        child: SearchBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              if (state is CharactersLoaded) {
                return CarouselSlider(
                  enableInfiniteScroll: false,
                  onPageChanged: (val) {
                    print(val);
                    index = val;
                    if (val == (state.characters.length - 1)) {
                      _charactersBloc.dispatch(FetchCharacters());
                    }
                  },
                  aspectRatio: 0.65,
                  // height: (MediaQuery.of(context).size.height -
                  //     appBar.preferredSize.height -
                  //     MediaQuery.of(context).padding.top) * 0.9,
                  items: state.characters.map((character) {
                    return Builder(
                      builder: (ctx) {
                        return index == (state.characters.length - 1) && !state.isLastPage
                            ? BottomLoader()
                            : Container(
                                child: CharacterCard(
                                  character: character,
                                ),
                              );
                      },
                    );
                  }).toList(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
