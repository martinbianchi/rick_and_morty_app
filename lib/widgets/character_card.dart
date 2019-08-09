import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/widgets/tag_info.dart';

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
        elevation: 6.0,
        child: Container(
          width: 300,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20.0)),
                child: Container(
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //     bottom: BorderSide(
                  //         width: 1,
                  //         color: Colors.black,
                  //         style: BorderStyle.solid),
                  //   ),
                  // ),
                  height: 300,
                  child: Image.network(
                    character.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  character.name,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TagInfo(
                      title: 'Status:',
                      value: character.status,
                    ),
                    TagInfo(
                      title: 'Species',
                      value: character.species,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TagInfo(
                      title: 'Gender:',
                      value: character.gender,
                    ),
                    Expanded(
                      child: TagInfo(
                        title: 'Type:',
                        value: character.type,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                child: ListTile(
                  title: Text(
                      '${character.origin.name}, ${character.origin.type}'),
                  subtitle: Text(character.origin.dimension),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.location_on,
                      size: 30.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
