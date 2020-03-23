import 'package:flutter/material.dart';
import 'package:practice/back/login_background.dart';
import 'package:practice/data/join_or_login.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //기본 화면
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CustomPaint(
              size: screenSize,
              painter: LoginBackground(
                  isJoin: Provider.of<JoinOrLogin>(context).isJoin),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _logoImg,
                Stack(
                  children: <Widget>[
                    _inputForm(screenSize),
                    _loginButton(screenSize)
                  ],
                ),
                //공간
                Container(
                  height: screenSize.height * 0.1,
                ),
                Consumer<JoinOrLogin>(
                    builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            value.toggle();
                          },
                          child: Text(
                            value.isJoin
                                ? "already haveit Sign in"
                                : "createOne",
                            style: TextStyle(
                                color: value.isJoin
                                    ? Colors.deepOrangeAccent
                                    : Colors.deepPurpleAccent),
                          ),
                        )),
                Container(
                  height: screenSize.height * 0.05,
                  width: 100,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // 위젯 01
  Widget _inputForm(Size size) {
    return Padding(
      /* * 체크  **/
      padding: EdgeInsets.all(size.width * 0.03),
      child: Card(
        elevation: 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_circle), labelText: "email"),
                  validator: (String emailID) {
                    if (emailID.isEmpty) {
                      return "check";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  //보안문자사용
                  obscureText: true,
                  controller: _pwController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key), labelText: "pws"),
                  validator: (String pw) {
                    if (pw.isEmpty) {
                      return "check please";
                    }
                    return null;
                  },
                ),
                Container(height: size.height * 0.01),
                Consumer<JoinOrLogin>(
                    builder: (context, value, child) => Opacity(
                          opacity: value.isJoin ? 0 : 1,
                          child: Text(
                            "forgot pw",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 위젯 02
  Widget _loginButton(Size size) => Positioned(
      left: size.width * 0.2,
      right: size.width * 0.2,
      bottom: 0,
      child: SizedBox(
        height: 50,
        child: Consumer<JoinOrLogin>(
          builder: (context, value, child) => RaisedButton(
            child: Text(
              value.isJoin ? "join " : "login",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            color: value.isJoin
                ? Colors.deepOrangeAccent
                : Colors.deepPurpleAccent,
            onPressed: () {
              if (_formKey.currentState.validate())
                print("correct" + _idController.text.toString());
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ));

  // 위젯 03
  Widget get _logoImg => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 70, right: 70),
          child: FittedBox(
            //동그란 이미지 틀
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/walking/walkincute.gif"),
            ),
          ),
        ),
      );
}
