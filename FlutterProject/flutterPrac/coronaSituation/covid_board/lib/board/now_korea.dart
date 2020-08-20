import 'package:flutter/material.dart';

//현재 우리나라의 상황을 보여줍니다.
class NowBoardPage extends StatelessWidget {
  BuildContext ctx;
  bool press = false;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _btn01(screenSize),
            ],
          )
        ],
      )),
//      하단메뉴네비게이션 부분이다.
      bottomNavigationBar: BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('화면1')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.mail), title: Text('화면2')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('화면3')),
        ],
      ),
    );
  }

//버튼 한개 생성하여 이 버튼을 통해 API정보 가져오는지 확인
  Widget _btn01(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.03),
      child: Card(
        elevation: 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 50),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.free_breakfast), labelText: "여기야"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RaisedButton(
                  child: Text("btn01"),
                  color: press ? Colors.blueAccent : Colors.blueGrey,
                  textColor: Colors.black87,
                  onPressed: () {
                    if (press) {
                      print("btni01_on");
                    } else {
                      print("btn01_off");
                    }
                    press = !press;
                  },
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
