import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter {
  //isJoin값에 따라서 배경색이 자동으로 변하게 하려고 받아온다.
  LoginBackground({@required this.isJoin});
  final bool isJoin;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isJoin ? Colors.lightGreen : Colors.deepPurpleAccent;

    canvas.drawDRRect(RRect.fromLTRBAndCorners(5.0, 5.0, 5.0, 5.0),
        RRect.fromLTRBAndCorners(5.0, 5.0, 5.0, 5.0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
