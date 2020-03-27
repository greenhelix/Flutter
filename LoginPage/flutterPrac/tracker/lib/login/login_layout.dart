import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//로그인 페이지 양식(화면 레이아웃)

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _authGlobalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }

  /*Firebase login method*/
  void _login(BuildContext loginContext) async {
    final AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passController.text);
    final FirebaseUser user = authResult.user;

    if (user == null) {
      final popup = SnackBar(
        content: Text("다시 작성해주세요."),
      );
      Scaffold.of(loginContext).showSnackBar(popup);
    }
  }

  /*Firebase register method*/
  void _register(BuildContext joinContext) async {
    final AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passController.text);
    final FirebaseUser user = authResult.user;

    if (user == null) {
      final popup = SnackBar(
        content: Text("다시 작성해주세요"),
      );
      Scaffold.of(joinContext).showSnackBar(popup);
    }
  }
}
