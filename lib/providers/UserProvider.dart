import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _isLogin = false;
  Map _user = {};
  Map _userInfo = {};

  bool get isLogin => _isLogin;

  bool get xLogin {
    return _isLogin;
  }

  Map get user => _user;

  Map get userInfo => _userInfo;

  set setUserInfo(Map userInfo) {
    _userInfo = userInfo;
  }

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
    _userInfo = {};

    notifyListeners();
  }
}
