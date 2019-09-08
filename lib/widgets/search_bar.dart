import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/blocs/characters/characters_bloc.dart';
import 'package:rick_and_morty_app/blocs/characters/characters_event.dart';

class SearchBar extends StatefulWidget {
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isSearching = false;

  @override
  PreferredSizeWidget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Rick and Morty'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        )
      ],
    );

    final searchBar = AppBar(
      title: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        onSubmitted: (val) {
          BlocProvider.of<CharactersBloc>(context).dispatch(
            SearchCharacters(searchText: val),
          );
        },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'Search by character name...',
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          BlocProvider.of<CharactersBloc>(context).dispatch(
            CancelSearch(),
          );
          setState(() {
            _isSearching = false;
          });
        },
      ),
    );

    return _isSearching ? searchBar : appBar;
  }
}
