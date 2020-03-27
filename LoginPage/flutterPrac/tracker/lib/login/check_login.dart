//가입을 했는지 안했는지 분별해주는 클래스
import 'package:flutter/widgets.dart';

class CheckLogin extends ChangeNotifier {
  bool _isJoin = false;
  bool get isJoin => _isJoin;

  void popCheckLogin() {
    _isJoin = !_isJoin;
    notifyListeners();
  }
}
