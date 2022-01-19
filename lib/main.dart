import 'package:ai_music_app/screens/Register.dart';
import 'package:ai_music_app/screens/Splash.dart';
import 'package:ai_music_app/screens/Start.dart';
import 'package:ai_music_app/screens/Login.dart';
import 'package:ai_music_app/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI_Music',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
