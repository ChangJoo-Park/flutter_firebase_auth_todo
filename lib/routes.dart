import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/screens/home_screen.dart';
import 'package:flutter_firebase_auth_app/screens/login_screen.dart';

final routes = {
  '/login': (BuildContext context) => new LoginScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/': (BuildContext context) => new LoginScreen(),
};
