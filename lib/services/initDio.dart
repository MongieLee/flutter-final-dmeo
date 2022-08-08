import 'dart:convert';

import 'package:dio/dio.dart';

Dio initDio() {
  BaseOptions options =
      // BaseOptions(baseUrl: 'http://mongielee.top:6606', connectTimeout: 3000);
      BaseOptions(baseUrl: 'http://192.168.8.29:8080', connectTimeout: 3000);
  Dio dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(onRequest: (reqOptions) {
    print(reqOptions.baseUrl);
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
