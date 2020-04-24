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


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
              // 로그인 정보가 없다면, 로그인/가입 페이지로 이동
            return ChangeNotifierProvider<JoinOrLogin>.value(
                value: JoinOrLogin(), child: AuthPage());
          } else {
              // 로그인 시 이동하느 화면
            return MainPage(email: snapshot.data.email);
          }
        });
  }
}
