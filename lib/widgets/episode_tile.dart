import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/episode.dart';

class EpisodeTile extends StatelessWidget {
  final Episode episode;

  const EpisodeTile({
    this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: FittedBox(
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Text(episode.episode),
          ),
        ),
      ),
      title: Text(episode.name),
      subtitle: Text('Air Date: ${episode.airDate}'),
    );
  }
}
