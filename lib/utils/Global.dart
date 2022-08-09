import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class G {
  static late FluroRouter router;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static BuildContext getCurrentContext() => navigatorKey.currentContext!;
}
