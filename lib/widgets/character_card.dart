import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/screens/character_detail_screen.dart';
import 'package:rick_and_morty_app/widgets/tile_info.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  CharacterCard({this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 3.0,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20.0)),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Image.network(
                        character.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (ctx, child, event) {
                          if (event == null) {
                            return child;
                          }
                          return Image.asset('assets/images/no-image.jpeg');
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.favorite_border),
                      iconSize: 35.0,
                      color: Colors.tealAccent,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    character.name,
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
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
              Spacer(),
              Divider(),
              ListTile(
                title: Text('View more...'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).pushNamed(
                      CharacterDetailScreen.routeName,
                      arguments: character.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
