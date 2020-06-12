import 'package:flutter/material.dart';

import 'board/now_korea.dart';

void main() => runApp(CovidBoardApp());

class CovidBoardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '코로나 상황판',
      darkTheme: ThemeData.dark(),
      home: NowBoardPage(), //첫화면은 우리나라의 상황
    );
  }
}
