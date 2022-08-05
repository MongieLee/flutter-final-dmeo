import 'dart:convert';

import 'package:dio/dio.dart';

Dio initDio() {
  BaseOptions options =
      // BaseOptions(baseUrl: 'http://mongielee.top:6606', connectTimeout: 3000);
      BaseOptions(baseUrl: 'http://192.168.8.207:5321', connectTimeout: 3000);
  Dio dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(onRequest: (reqOptions) {
    print(reqOptions);
  }, onResponse: (res) {
    if (res.statusCode == 200) {
      return json.encode(res.data?['result']);
    }
    return res;
  }, onError: (error) {
    print(error);
  }));
  return dio;
}
