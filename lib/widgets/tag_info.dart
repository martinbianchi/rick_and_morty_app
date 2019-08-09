import 'package:flutter/material.dart';

class TagInfo extends StatelessWidget {
  final String title;
  final String value;

  const TagInfo({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 60,
          child: FittedBox(
            child: Text(
              (value != null && value != '') ? value : 'Unknown',
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
