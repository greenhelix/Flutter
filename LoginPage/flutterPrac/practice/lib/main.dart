import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/data/join_or_login.dart';
import 'package:practice/layout/login.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppPractice());

class AppPractice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider<JoinOrLogin>.value(
            value: JoinOrLogin(), child: AuthPage()));
  }
}
