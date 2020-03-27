import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/login/check_login.dart';
import 'package:tracker/login/login_layout.dart';
import 'package:tracker/login/success_login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FireBaseConnect(),
    );
  }
}

class FireBaseConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<CheckLogin>.value(
                value: CheckLogin(), child: AuthPage());
          } else {
            return SuccessLoginPage(email: snapshot.data.email);
          }
        });
  }
}
