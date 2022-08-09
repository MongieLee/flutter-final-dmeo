import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_demo/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import '../utils/Global.dart';

Dio initDio() {
  BaseOptions options =
      // BaseOptions(baseUrl: 'http://mongielee.top:6606', connectTimeout: 3000);
      BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: 3000,
  );
  options.headers["Content-Type"] = "application/json";
  Dio dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(onRequest: (reqOptions) {
    print(reqOptions.baseUrl);
    var user = G.getCurrentContext().read<UserProvider>().user;
    if (user.isNotEmpty) {
      ///设置请求头
      options.headers["Authorization"] = user["access_token"];
    }
  }, onResponse: (res) {
    if (res.statusCode == 200) {
      print('请求成功');
      // print(res.data);
      // return json.decode(res.data);
    }
  }, onError: (error) {
    print(error);
  }));
  return dio;
}
