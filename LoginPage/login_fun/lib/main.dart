import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/data/join_or_login.dart';
import 'package:loginpage/layout/login.dart';
import 'package:loginpage/layout/main_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}

//첫 페이시 로고 보여주는 것을 splash라고 함
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<JoinOrLogin>.value(
                value: JoinOrLogin(), child: AuthPage());
          } else {
            return MainPage(email: snapshot.data.email);
          }
        });
  }
}
