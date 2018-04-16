import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/routes.dart';

void main() => runApp(new FirebaseAuthApp());

class FirebaseAuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Login App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: routes,
    );
  }
}
