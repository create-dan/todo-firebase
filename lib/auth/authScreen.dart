// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'authForm.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Authentication",
          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink,
      ),
      body: AuthForm(),
    );
  }
}
