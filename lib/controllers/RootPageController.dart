import 'package:flutter/material.dart';
import '../pages/RootPage.dart';
import '../pages/HomePage.dart';

class RootPageController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootPageControllerState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageControllerState extends State<RootPageController> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return RootPage();
      case AuthStatus.signedIn:
        return HomePage();
    }
  }
}
