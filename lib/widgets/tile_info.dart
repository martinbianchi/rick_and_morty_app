import 'package:flutter/material.dart';

class TileInfo extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;

  TileInfo({
    @required this.title,
    @required this.info,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ListTile(
        dense: true,
        leading: IconButton(
          icon: Icon(icon, color: Colors.teal,),
          onPressed: null,
        ),
        subtitle: Text(info),
        title: Text(title),
      ),
    );
  }
}
