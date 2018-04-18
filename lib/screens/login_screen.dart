import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_firebase_auth_app/store.dart' as store;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  Future ensureLogIn() async {
    dynamic user = await store.logIn;
    if (user) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  Future<FirebaseUser> _testSignInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken,
    );

    print("User Name : ${user.displayName}");
    return user;
  }

  @override
  void initState() {
    super.initState();
    this.ensureLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: formKey,
          child: _isLoading
              ? new Container(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(),
                )
              : new Column(
                  children: <Widget>[
                    const SizedBox(height: 24.0),
                    new Text(
                      'Login App',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    new RaisedButton(
                      onPressed: () =>
                          _testSignInWithGoogle().then((FirebaseUser user) {
                            Navigator.of(context).pushReplacementNamed('/home');
                          }).catchError((e) => print(e)),
                      child: new Text('Sign In With Google'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
