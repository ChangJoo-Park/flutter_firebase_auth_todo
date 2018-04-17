import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

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

  String _email, _password = '';
  bool _isLoading = false;

  Future<FirebaseUser> _testSignInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    print("User Name : ${user.displayName}");
    return user;
  }

  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = _googleSignIn.currentUser;

    if (user == null) {
      print('first user check $user');
      user = await _googleSignIn.signInSilently();
    }

    if (user == null) {
      print('second user check $user');
      await _googleSignIn.signIn();
      // analytics.logLogin();
    }

    if (await _auth.currentUser() == null) {
      print('third user check $user');
      GoogleSignInAuthentication credentials =
          await _googleSignIn.currentUser.authentication;
      await _auth.signInWithGoogle(
        idToken: credentials.idToken,
        accessToken: credentials.accessToken,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    (() async {
      await _ensureLoggedIn();
    });
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
                      onPressed: () => _testSignInWithGoogle()
                          .then((FirebaseUser user) {
                            Navigator.of(context).pushReplacementNamed('/home');
                          })
                          .catchError((e) => print(e)),
                      child: new Text('Sign In With Google'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
