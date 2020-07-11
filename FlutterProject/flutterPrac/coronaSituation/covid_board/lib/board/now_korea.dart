import 'package:flutter/material.dart';

//현재 우리나라의 상황을 보여줍니다.
/*여기 첫 화면부터 만든다.*/
class NowBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        elevation: 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
