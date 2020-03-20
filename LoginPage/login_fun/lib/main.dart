import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/data/join_or_login.dart';
import 'package:loginpage/layout/login.dart';
import 'package:provider/provider.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider<JoinOrLogin>.value(
            value: JoinOrLogin(), child: AuthPage()));
  }
}
