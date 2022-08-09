import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _isLogin = false;
  Map _user = {};

  bool get isLogin => _isLogin;

  bool get xLogin {
    return _isLogin;
  }

  Map get user => _user;

  doLogin(data) {
    if (data != null) {
      _isLogin = true;
      _user = data;

      notifyListeners();
    }
  }

  doLogout() {
    _isLogin = false;
    _user = {};

    notifyListeners();
  }
}
