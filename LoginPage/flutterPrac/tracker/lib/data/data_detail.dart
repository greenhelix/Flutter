import 'package:flutter/material.dart';

class DataDetailLayout extends StatefulWidget {
  @override
  _DataDetailLayoutState createState() => _DataDetailLayoutState();
}

class _DataDetailLayoutState extends State<DataDetailLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('세부설정 화면'),
      ),
      body: Container(
        color: Colors.amberAccent,
        child: Center(child: Text('세부설정 화면입니다.')),
      ),
    );
  }
}
