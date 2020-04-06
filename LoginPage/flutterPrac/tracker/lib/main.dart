import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/login/login_layout.dart';
import 'package:tracker/map/track_map_layout.dart';
import 'login/check_login.dart';

void main() => runApp(EccentricApp());

class EccentricApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EccentricPath',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<CheckLogin>.value(
                value: CheckLogin(), child: AuthPage());
          } else {
            return MyHomePage(email: snapshot.data.email, title: "지도화면");
          }
        });
  }
}
