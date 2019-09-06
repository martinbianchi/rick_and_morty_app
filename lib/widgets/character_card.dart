import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/blocs/character/character_bloc.dart';
import 'package:rick_and_morty_app/blocs/character/character_event.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/screens/character_detail_screen.dart';
import 'package:rick_and_morty_app/widgets/tag_info.dart';
import 'package:rick_and_morty_app/widgets/tile_info.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  CharacterCard({this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 3.0,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20.0)),
                child: Container(
                  height: 300,
                  child: Image.network(
                    character.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    character.name,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TileInfo(
                icon: Icons.face,
                title: 'Status',
                info: character.status,
              ),
              TileInfo(
                icon: Icons.bug_report,
                title: 'Specie',
                info: character.species,
              ),
              TileInfo(
                icon: Icons.directions_walk,
                title: 'Type',
                info: character.type,
              ),
              Divider(),
              ListTile(
                title: Text('View more...'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).pushNamed(
                      CharacterDetailScreen.routeName, arguments: character.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
