import 'package:dio/dio.dart';

import '../DioRequest.dart';

class AuthService {
  static final Dio dio = DioRequest.getDioRequest();

  static Future<dynamic> login() {
    return dio.post('/api/TokenAuth/Authenticate', data: {
      'userNameOrEmailAddress': 'admin',
      'password': '123qwe',
    });
  }
}
