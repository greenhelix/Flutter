import 'package:flutter/material.dart';
import 'package:tracker/custom/login_back.dart';

class DataDetailLayout extends StatefulWidget {
  @override
  _DataDetailLayoutState createState() => _DataDetailLayoutState();
}

class _DataDetailLayoutState extends State<DataDetailLayout> {
  @override
  Widget build(BuildContext context) {
    final Size backgroundSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('세부설정 화면'),
        backgroundColor: Colors.transparent,
        actions: <Widget>[_detailControlPopup()],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _dataInputForm(backgroundSize),
        ],
      ),
    );
  }
}

//상단 팝업 메뉴 리스트
Widget _detailControlPopup() => PopupMenuButton<int>(
    itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              '저장',
              style: TextStyle(color: Colors.black),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              '공유하기',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: Text(
              '삭제',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ]);

Widget _dataInputForm(Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Stack(
        children: <Widget>[
          //사진
          Container(),
          //경로이름
          Container(),
          //날짜
          Container(),
          //거리
          Container(),
          //수단
          Container(),
        ],
      ),
      //공간
      SizedBox(),
      //지도
      Container(),
      //공간
      SizedBox(),
      //버튼
      RaisedButton(
        onPressed: () {},
        child: Text('경로에 사진 추가하기'),
      )
    ],
  );
}
