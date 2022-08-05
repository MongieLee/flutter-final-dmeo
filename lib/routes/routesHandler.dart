import 'package:final_demo/pages/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../pages/home/Home.dart';
import '../pages/mine/Mine.dart';
import '../pages/study/Study.dart';
import '../pages/user/Login.dart';
import '../pages/notFound/NotFound.dart';

var HomeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return IndexPage();
});

var LoginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LoginPage();
});

var NotFoundHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return NotFoundPage();
});
