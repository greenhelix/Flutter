import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker/data/line_data.dart';

class DrawerLayout extends StatelessWidget {
  DrawerLayout(this.email);
  final String email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.6,
        child: Drawer(
            child: ListView(
          children: <Widget>[
            Container(
                height: 55,
                color: Colors.cyanAccent,
                child: Row(
                  children: <Widget>[
                    DrawerHeader(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.yellow,
                          ),
                          Container(
                            width: size.width * 0.04,
                          ),
                          Text(email.substring(0, 5)),
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                          ButtonTheme(
                            buttonColor: Colors.white70,
                            minWidth: 60,
                            height: 30,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                              child: new Text(
                                "로그아웃",
                                style: TextStyle(fontSize: 10),
                              ),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            ListTile(
              title: Text('사 용 자 정 보'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('내 경 로'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LineDataSheet()));
              },
            ),
            ListTile(
              title: Text('환경 설정'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        )));
  }
}
