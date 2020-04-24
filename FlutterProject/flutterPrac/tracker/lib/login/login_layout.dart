import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/custom/login_back.dart';
import 'package:tracker/login/check_login.dart';

//로그인 페이지 양식(화면 레이아웃)

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _authGlobalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
                  isJoin: Provider.of<CheckLogin>(context).isJoin),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _loginImg,
                Stack(
                  children: <Widget>[
                    _inputForm(screenSize),
                    _loginButton(screenSize)
                  ],
                ),
                Container(
                  height: screenSize.height * 0.1,
                ),
                Consumer<CheckLogin>(
                  builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      value.popCheckLogin();
                    },
                    child: Text(
                        value.isJoin
                            ? "이미 계정이 있습니까? 그럼 로그인하세요."
                            : "계정이 없으십니까 ? 그럼 새로 하나 생성하세요.",
                        style: TextStyle(
                            color: value.isJoin
                                ? Colors.deepOrangeAccent
                                : Colors.deepPurpleAccent)),
                  ),
                ),
                Container(height: screenSize.height * 0.05, width: 100)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get _loginImg => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 70, right: 70),
          child: FittedBox(
            child: CircleAvatar(
              backgroundColor: Colors.yellow,
            ),
          ),
        ),
      );

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        elevation: 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 50),
          child: Form(
            key: _authGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle), labelText: "email"),
                    validator: (String emailID) {
                      if (emailID.isEmpty) {
                        return "정확한 이메일을 입력해주세요.";
                      }
                      return null;
                    }),
                TextFormField(
                    obscureText: true,
                    controller: _passController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key), labelText: "비밀번호"),
                    validator: (String pw) {
                      if (pw.isEmpty) {
                        return "정확한 비밀번호를 입력해주세요.";
                      }
                      return null;
                    }),
                Consumer<CheckLogin>(
                    builder: (context, value, child) => Opacity(
                          opacity: value.isJoin ? 0 : 1,
                          child: Text("비번을 잊으셨습니까?",
                              style: TextStyle(color: Colors.blueAccent)),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(Size size) => Positioned(
        left: size.width * 0.2,
        right: size.width * 0.2,
        bottom: 0,
        child: SizedBox(
          height: 50,
          child: Consumer<CheckLogin>(
              builder: (context, value, child) => RaisedButton(
                    child: Text(
                      value.isJoin ? "가  입" : "로  그  인",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: value.isJoin ? Colors.deepOrange : Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    onPressed: () {
                      if (_authGlobalKey.currentState.validate())
                        value.isJoin ? _register(context) : _login(context);
                    },
                  )),
        ),
      );

  /*Firebase login method*/
  void _login(BuildContext loginContext) async {
    final AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passController.text);
    final FirebaseUser user = authResult.user;

    if (user == null) {
      final popup = SnackBar(
        content: Text("다시 작성해주세요."),
      );
      Scaffold.of(loginContext).showSnackBar(popup);
    }
  }

  /*Firebase register method*/
  void _register(BuildContext joinContext) async {
    final AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passController.text);
    final FirebaseUser user = authResult.user;

    if (user == null) {
      final popup = SnackBar(
        content: Text("다시 작성해주세요"),
      );
      Scaffold.of(joinContext).showSnackBar(popup);
    }
  }
}
