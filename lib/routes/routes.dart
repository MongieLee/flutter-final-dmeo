import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'routesHandler.dart';

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.define('/', handler: HomeHandler);
    router.define('/login', handler: LoginHandler);
    router.notFoundHandler = NotFoundHandler;
  }
}
