import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Color backgroundColor;
  final Color primaryColor;
  final String title;
  final String planetName;
  final String planetType;
  final String dimension;

  const InfoCard({
    @required this.backgroundColor,
    @required this.primaryColor,
    @required this.title,
    @required this.planetName,
    @required this.planetType,
    @required this.dimension,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(),
      child: Container(
        width: double.infinity,
        // height: 150,
        padding: EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Row(
          
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Text(
                    '$title',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.my_location,
                    size: 60.0,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Name: $planetName'),
                  Text('Type: $planetType'),
                  Text(dimension)
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
