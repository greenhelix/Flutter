import 'package:flutter/material.dart';

// 직접 화면에 그려주느 클래스이다.
// CustomPainter를 Extends시켜서, 이를 통해 값들과 모양을 정해주고, 이것을 원하는 곳에 끌어다 쓰면된다.
class LoginBackground extends CustomPainter {
  LoginBackground({@required this.isJoin});
  final bool isJoin;

  @override
  void paint(Canvas canvas, Size size) {
    //colorS로 값을 지정해주고, Paint 오브젝트에 넣어준다는 것이다. 페인트 통에 잉크를 넣는 격
    // c 떨어질 거리, radius 반지름 , paint 색
    // isJoin 값을 가져와서 그 값이 true 이면, orange색으로, 아니면, purple색으로 해준다.
    Paint paint = Paint()
      ..color = isJoin ? Colors.deepOrangeAccent : Colors.deepPurpleAccent;
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.3), size.height * 0.5, paint);
  }
  //Offset(x값, y값)  x는 가로 y 세로 값으로, size.를 통해서 화면 전체적인 위치 혹은 세부적이게 위치조절가능

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
