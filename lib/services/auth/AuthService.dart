import 'dart:convert';

import 'package:dio/dio.dart';

import '../DioRequest.dart';

class AuthService {
  static final Dio dio = DioRequest.getDioRequest();

  static Future<dynamic> login(
      {required String username, required String password}) async {
    Response res = await dio.post('/api/v1/auth/login',
        data: json.encode({"username": username, 'password': password}));
    return res.data['data'];
  }

  static Future<dynamic> getUserInfo(
      {required String username, required String password}) async {
    Response res = await dio.get('/api/v1/auth/getUserInfo');
    return res.data["data"];
  }
}
