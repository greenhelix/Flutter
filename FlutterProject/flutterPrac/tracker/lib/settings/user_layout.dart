import 'package:flutter/material.dart';

class UserSettingsLayout extends StatefulWidget {
  @override
  _UserSettingsLayoutState createState() => _UserSettingsLayoutState();
}

class _UserSettingsLayoutState extends State<UserSettingsLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 설정'),
      ),
      body: Center(
        child: Container(
          child: Text('사용자 설정 화면입니다.'),
        ),
      ),
    );
  }
}
