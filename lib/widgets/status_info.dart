import 'package:flutter/material.dart';

class StatusInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text('Status: ', style: Theme.of(context).textTheme.title,),
        SizedBox(width: 10.0,),
        // Icon(MdiIcons.emoticonExcited)
        Text('Alive!')
      ],
    );
  }
}