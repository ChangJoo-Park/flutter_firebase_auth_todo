import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  GoogleSignInAccount _user;

  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = _googleSignIn.currentUser;

    if (user == null) {
      user = await _googleSignIn.signInSilently();
    }

    if (user == null) {
      await _googleSignIn.signIn();
      // analytics.logLogin();
    }

    if (await _auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await _googleSignIn.currentUser.authentication;
      await _auth.signInWithGoogle(
        idToken: credentials.idToken,
        accessToken: credentials.accessToken,
      );
    }
    if (user != null) {
      setState(() {
        this._user = user;
      });
      print('user has exists');
    }
  }

  @override
  void initState() {
    super.initState();
    (() async {
      print("before ensure logged in");
      await _ensureLoggedIn();
      print("after ensure logged in");
    })();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.exit_to_app),
            onPressed: () async {
              await _googleSignIn.signOut();
              await _auth.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: new Center(
        child: new Text(''),
      ),
    );
  }
}
