import 'package:flutter/material.dart';
import 'package:tracker/draw_menu/drawer_layout.dart';

//로그인 성공시 보여지는 화면
class SuccessLoginPage extends StatelessWidget {
  SuccessLoginPage({this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerLayout(),
      ),
    );
  }
}
