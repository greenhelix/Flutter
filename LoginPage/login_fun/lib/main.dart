import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/layout/login.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AuthPage());
  }
}
