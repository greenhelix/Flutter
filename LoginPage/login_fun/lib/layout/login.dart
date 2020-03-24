import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/back/login_background.dart';
import 'package:loginpage/data/join_or_login.dart';
import 'package:loginpage/layout/main_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  // flutter에서 key는 아이디라고 보면된다.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //controller
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //모든 폰의 화면사이즈 값을 설정 및 선언한다.
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CustomPaint(
              //반드시 화면사이즈를 지정해서 끌어줘야 한다. 안그러면 구동이 안됨
              size: screenSize,
              painter: LoginBackground(
                  // JoinOrLogin  의 isJoin boolean 값을 가져온다는 의미이다.
                  isJoin: Provider.of<JoinOrLogin>(context).isJoin),
            ), //배경부분
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              //사진들어갈 공간(파라미터 받을게 없는 경우 이렇게 변수선언처럼 선언도 된다...)
              children: <Widget>[
                _logoImg,
                Stack(
                  children: <Widget>[
                    //inputForm위젯 메서드를 통해 코드를 단순화 작업함. size(화면크기)값을 갖다 쓰기위해 파라미터 넣어줌.
                    _inputForm(screenSize),
                    _loginButton(screenSize),
                  ],
                ), //아이디/비번 입력 공간
                Container(
                  height: screenSize.height * 0.1,
                ), //텍스트와 객체들 사이 공간
                //컨슈머를 통해서 builder를 통해  값을 가져오고, 이를 편하게 사용한다. 원하는 값의 이름은 원하는
                //이름으로 설정해서 쓸 수 있다. 각 조건에 따라 조건식을 걸어 둘수도 있다.
                Consumer<JoinOrLogin>(
                  builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        value.toggle();
                      },
                      child: Text(
                        value.isJoin
                            ? "Already Have an Account? Sign In"
                            : "Dont Have Account? Create One",
                        style: TextStyle(
                            color: value.isJoin
                                ? Colors.deepOrangeAccent
                                : Colors.deepPurpleAccent),
                      )), // 계정 생성 공간
                ),

                Container(
                  height: screenSize.height * 0.05,
                  width: 100,
                ) // 텍스트 밑 최하단의 공간
              ],
            ) // 배경위에 모든것들(수직으로쌓아준다)
          ],
        ),
      ),
    );
  }

  //로그인 페이지 형식
  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        // 카드 부분 그림자 지정
        elevation: 8.0,
        // 카드 전체에 테두리 원형으로 만드는 부분
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        // 카드 안의 들어있는 것들의 틀 부분
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 50),
          child: Form(
              // 아이디 키 값을 주워 찾기 쉽게해준다.웬만하면 데이터가 있는 부분인듯
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle), labelText: "이메일 주소"),
                    validator: (String emailID) {
                      if (emailID.isEmpty) {
                        return "Please Input Correct Email.";
                      }
                      return null;
                    },
                  ),
                  // obscureText => 문자를 점점으로 안보이게 해준다.
                  TextFormField(
                    obscureText: true,
                    controller: _pwController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key), labelText: "비밀번호"),
                    validator: (String pw) {
                      if (pw.isEmpty) {
                        return "Please Input Correct Password.";
                      }
                      return null;
                    },
                  ),
                  Consumer<JoinOrLogin>(
                    builder: (context, value, child) => Opacity(
//                    opacity: Provider.of<JoinOrLogin>(context).isJoin, 이렇게 쓰면, context가 없는 메서드라 적용이 안됨.
                      // 그래서 consumer를 사용한다.
                      opacity: value.isJoin ? 0 : 1,
                      // opacity 0과 1로 설정해서 보였다(1)/ 안보였다(0) 하는 것임.
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  //로그인 버튼 형식
  Widget _loginButton(Size size) => Positioned(
        left: size.width * 0.2,
        right: size.width * 0.2,
        bottom: 0,
        child: SizedBox(
          height: 50,
          child: Consumer<JoinOrLogin>(
            builder: (context, value, child) => RaisedButton(
              child: Text(
                value.isJoin ? "가 입" : "로 그 인",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              color: value.isJoin ? Colors.deepOrangeAccent : Colors.deepPurple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              onPressed: () {
                // formkey 부분아이디를 찾아서 그곳에 있는 validator에 해당하는 값들이 있는지 확인
                if (_formKey.currentState.validate())
                  value.isJoin ? _register(context) : _login(context);
              },
            ),
          ),
        ),
      );

  //로고이미지 넣는곳으로써,, 파라미터 가져올게 없으면, Get으로 표현해서 마치 객체 위젯처럼 쓸수도 있다.
  Widget get _logoImg => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 70, right: 70),
          child: FittedBox(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/walkincute.gif"),
            ),
          ),
        ),
      );

  void _register(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _idController.text, password: _pwController.text);
    final FirebaseUser user = result.user;

    if (user == null) {
      // 메세지 올려주는 기능 sanckBar
      final snacBar = SnackBar(
        content: Text("Please try again please."),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }

    //화면이동 시키기
//    Navigator.push(context,
//        MaterialPageRoute(builder: (context) => MainPage(email: user.email)));
  }

  void _login(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _idController.text, password: _pwController.text);
    final FirebaseUser user = result.user;

    if (user == null) {
      final snacBar = SnackBar(
        content: Text("Please try again please."),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }
}

// 네트워크를 통한 이미지 올릴 때.
// NetworkImage(
//                  "https://i.pinimg.com/originals/7e/f8/c4/7ef8c486ba15bdd66c1dbc4f2b48465c.gif")
