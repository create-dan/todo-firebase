// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/auth/authScreen.dart';
import 'package:todo_firebase/screen/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        builder: (context, usersnapshot) {
          if (usersnapshot.hasData) {
            return HomePage();
          } else {
            return AuthScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pink,
      ),
    );
  }
}
