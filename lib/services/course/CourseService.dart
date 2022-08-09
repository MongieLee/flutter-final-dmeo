import 'package:dio/dio.dart';

import '../DioRequest.dart';

class CourseService {
  static final Dio dio = DioRequest.getDioRequest();

  static Future<dynamic> getCourses() {
    return dio
        .get('/api/v1/base/getCourses')
        .then((value) => value.data['data']);
  }

  static Future<dynamic> getDetailById(int carouseId) {
    return dio
        .get('/api/v1/course/$carouseId')
        .then((value) => value.data['data']);
  }
}
