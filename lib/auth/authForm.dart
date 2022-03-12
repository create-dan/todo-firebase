// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _email = "";
  var _password = "";
  var _username = "";
  bool isLoginPage = false;

  startAuthentication() {
    final validity = _formkey.currentState!.validate();

    FocusScope.of(context).unfocus();
    if (validity) {
      _formkey.currentState?.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      if (isLoginPage) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String? uid = authResult.user?.uid;
        await FirebaseFirestore.instance.collection('user').doc(uid).set({
          'username': username,
          'email': email,
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isLoginPage)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Incorrect Username";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _username:
                        value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide()),
                        labelText: "Enter Username ",
                        labelStyle:
                            GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                    ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('email'),
                    validator: (String? value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "Incorrect Email";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email:
                      value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide()),
                      labelText: "Enter Email",
                      labelStyle:
                          GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    key: ValueKey('Password'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Incorrect Password";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password:
                      value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide()),
                      labelText: "Enter Password",
                      labelStyle:
                          GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height: 80.0,
                    child: RaisedButton(
                      child: isLoginPage
                          ? Text(
                              "Login",
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "Sign Up",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        startAuthentication();
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isLoginPage = !isLoginPage;
                        });
                      },
                      child: isLoginPage
                          ? Text("Not a Member")
                          : Text("Already a User"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
