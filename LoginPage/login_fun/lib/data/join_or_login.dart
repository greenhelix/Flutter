import 'package:flutter/foundation.dart';

// 이 클래스에 영향을 받는 위젯등은 모두 어떠한 값이 바뀌면 바뀐 것의 알림을 받는다.
class JoinOrLogin extends ChangeNotifier {
  bool _isJoin = false;
  bool get isJoin => _isJoin;

  void toggle() {
    _isJoin = !_isJoin;
    notifyListeners();
  }
}
