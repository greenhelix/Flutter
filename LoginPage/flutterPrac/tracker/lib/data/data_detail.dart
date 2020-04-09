import 'package:flutter/material.dart';
import 'package:tracker/custom/login_back.dart';

class DataDetailLayout extends StatefulWidget {
  @override
  _DataDetailLayoutState createState() => _DataDetailLayoutState();
}

class _DataDetailLayoutState extends State<DataDetailLayout> {
  @override
  Widget build(BuildContext context) {
    final Size background = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('세부설정 화면'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  //저장시 입력되는 값들, 필드값이 들어오게 하는 부분
                  // 사진 등록 가능하게
                  // 경로이름
                  // 날짜
                  // 거리
                  // 수단
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
