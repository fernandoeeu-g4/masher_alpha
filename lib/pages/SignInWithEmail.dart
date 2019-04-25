import 'package:flutter/material.dart';

class SignInWithEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login com email"),
      ),
      body: Container(
        child: Text('Olá!'),
      ),
    );
  }
}
