import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_demo/services/initDio.dart';

import '../DioRequest.dart';

class FileService {
  static final Dio dio = DioRequest.getDioRequest();

  static Future<dynamic> singleUploadFile({required FormData file}) async {
    // Dio dio = initDio(isMultipart: true);
    Response res = await Dio()
        .post('http://192.168.8.29:8080/api/v1/file/singleUpload', data: file);
    // Response res = await dio.post('/api/v1/file/singleUpload', data: file);
    return res.data['data'];
  }
}
