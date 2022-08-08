import 'package:dio/dio.dart';

import '../DioRequest.dart';

class HomeService {
  static final Dio dio = DioRequest.getDioRequest();

  static Future<dynamic> getCarousels() {
    return dio.get('/api/v1/getCarousels').then((res) => res.data['data']);
  }
}
