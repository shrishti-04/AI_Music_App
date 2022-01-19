import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class MusicGames extends StatefulWidget {
  // const MusicGames({ Key? key }) : super(key: key);

  @override
  _MusicGamesState createState() => _MusicGamesState();
}

class _MusicGamesState extends State<MusicGames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 800,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF343434),
                  Color(0xFF343434),
                  Color(0xFF832078),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.all(180),
                ),
                Container(
                  child: Text(
                    'Lets have a game!! gg 🔥',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
