import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/blocs/character/character_bloc.dart';
import 'package:rick_and_morty_app/blocs/character/character_event.dart';
import 'package:rick_and_morty_app/blocs/character/character_state.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/widgets/info_card.dart';

class CharacterDetailScreen extends StatefulWidget {
  static const routeName = '/character-detail';

  final CharacterRepository characterRepository;
  CharacterDetailScreen({this.characterRepository});

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  CharacterBloc _characterBloc;
  var _isInit = true;

  @override
  void initState() {
    _characterBloc =
        CharacterBloc(characterRepository: widget.characterRepository);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _characterBloc.dispatch(
          FetchCharacter(ModalRoute.of(context).settings.arguments as int));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (ctx) => _characterBloc,
      child: BlocBuilder<CharacterBloc, CharacterState>(
        bloc: _characterBloc,
        builder: (context, CharacterState state) {
          if (state is CharacterLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text(state.character.name),
              ),
              body: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.network(
                        state.character.imageUrl,
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        InfoCard(
                          title: 'Origin',
                          planetName: state.character.origin.name,
                          planetType: state.character.origin.type,
                          dimension: state.character.origin.dimension,
                          primaryColor: Colors.teal,
                          backgroundColor: Colors.white,
                        ),
                        InfoCard(
                          title: 'Last Location',
                          planetName: state.character.lastLocation.name,
                          planetType: state.character.lastLocation.type,
                          dimension: state.character.lastLocation.dimension,
                          primaryColor: Colors.white,
                          backgroundColor: Colors.teal,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
