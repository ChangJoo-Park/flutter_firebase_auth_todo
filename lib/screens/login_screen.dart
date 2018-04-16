import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          child: new Column(
            children: <Widget>[
              new TextFormField(
                autofocus: true,
                decoration: new InputDecoration(
                  border: const UnderlineInputBorder(),
                  icon: const Icon(Icons.email),
                  labelText: 'E-mail',
                  hintText: 'admin@example.com',
                ),
              ),
              const SizedBox(height: 24.0),
              new TextFormField(
                obscureText: true,
                decoration: new InputDecoration(
                  border: const UnderlineInputBorder(),
                  icon: const Icon(Icons.lock),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 24.0),
              new RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: new Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
