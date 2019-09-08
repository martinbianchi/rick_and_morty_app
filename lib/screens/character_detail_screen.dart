import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/blocs/character/character_bloc.dart';
import 'package:rick_and_morty_app/blocs/character/character_event.dart';
import 'package:rick_and_morty_app/blocs/character/character_state.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/widgets/episode_tile.dart';
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
    // _characterBloc =
    //     CharacterBloc(characterRepository: widget.characterRepository);
    _characterBloc = BlocProvider.of<CharacterBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _characterBloc.dispatch(
          FetchCharacter(ModalRoute.of(context).settings.arguments as String));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _buildSliverAppBar(CharacterLoaded state) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height *0.5,
      floating: false,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            centerTitle: true,
            title: constraints.biggest.height > 120
                ? _buildExpandedTitle(state.character.name)
                : Text(state.character.name),
            background: Image.network(
              state.character.imageUrl,
              fit: BoxFit.fitWidth,
            ),
          );
        },
      ),
    );
  }

  _buildExpandedTitle(String name) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
      child: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  _buildCharacterInfo(CharacterLoaded state) {
    return Column(
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
        ExpansionTile(
          title: Text('Episodes'),
          leading: Icon(Icons.tv),
          initiallyExpanded: true,
          children: state.character.episodes
              .map((e) => EpisodeTile(
                    episode: e,
                  ))
              .toList(),
        )
      ],
    );
  }

  buildSliverAppBar(String imageUrl, Widget child, CharacterLoaded state) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildSliverAppBar(state),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    _buildCharacterInfo(state),
                  ],
                ),
              ),
            ),
            childCount: 1,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
        bloc: _characterBloc,
        builder: (context, CharacterState state) {
          if (state is CharacterLoaded) {
            return Scaffold(
              body: buildSliverAppBar(state.character.imageUrl, null, state),
            );
          }

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
    );
  }
}
