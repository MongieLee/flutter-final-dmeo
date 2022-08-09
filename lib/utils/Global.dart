import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class G {
  static late FluroRouter router;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static BuildContext getCurrentContext() => navigatorKey.currentContext!;

  static parseQuery(Map<String, dynamic> params) {
    String result = '';
    int index = 0;
    for (String key in params.keys) {
      final String value = Uri.encodeComponent(params[key].toString());
      if (index == 0) {
        result = '?';
      } else {
        result += '&';
      }
      result += '$key=$value';
      index++;
    }
    return result;
  }
}
