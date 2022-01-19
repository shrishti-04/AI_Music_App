import 'package:ai_music_app/tabs/AiRadio.dart';
import 'package:ai_music_app/tabs/Home.dart';
import 'package:ai_music_app/tabs/MusicGames.dart';
import 'package:ai_music_app/tabs/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ai_music_app/screens/Start.dart';

class NavigationBar extends StatefulWidget {
  // const NavigationBar({ Key? key }) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    AiRadio(),
    MusicGames(),
    Profile(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.black.withOpacity(0.7),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_rounded),
            title: Text('Radio'),
            backgroundColor: Colors.black.withOpacity(0.7),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games_rounded),
            title: Text('Games'),
            backgroundColor: Colors.black.withOpacity(0.7),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            backgroundColor: Colors.black.withOpacity(0.7),
          ),
        ],
        onTap: onTappedBar,
      ),
    );
  }
}
