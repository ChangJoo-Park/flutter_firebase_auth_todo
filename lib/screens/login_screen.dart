import 'dart:async';

import 'package:flutter/material.dart';

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

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print("form show");
      print(_email);
      print(_password);

      setState(() => _isLoading = true);

      new Timer(const Duration(seconds: 3), () {
        if (_email == 'a' && _password == 'b') {
          Navigator.of(context).pushReplacementNamed('/home');
          return;
        }
        scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text('로그인 실패, 이메일은 a, 비밀번호는 b')));
        setState(() => _isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                autofocus: true,
                onSaved: (val) => _email = val,
                decoration: new InputDecoration(
                  border: const UnderlineInputBorder(),
                  icon: const Icon(Icons.email),
                  labelText: 'E-mail',
                  hintText: 'admin@example.com',
                ),
              ),
              const SizedBox(height: 24.0),
              new TextFormField(
                onSaved: (val) => _password = val,
                obscureText: true,
                decoration: new InputDecoration(
                  border: const UnderlineInputBorder(),
                  icon: const Icon(Icons.lock),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 24.0),
              _isLoading
                  ? new CircularProgressIndicator()
                  : new RaisedButton(
                      onPressed: _submit, child: new Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
