import 'package:dio/dio.dart';

import 'initDio.dart';

class DioRequest {
  static final Dio _dio = initDio();

  static getDioRequest() {
    return _dio;
  }
}
