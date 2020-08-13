import 'package:flutter/material.dart';

//현재 우리나라의 상황을 보여줍니다.
/*여기 첫 화면부터 만든다.*/
class NowBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    child: Form(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                      ],
                    )),
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
