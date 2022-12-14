import 'package:final_demo/pages/index.dart';
import 'package:final_demo/pages/mine/Profile.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../pages/home/Home.dart';
import '../pages/mine/Mine.dart';
import '../pages/study/Study.dart';
import '../pages/user/Login.dart';
import '../pages/notFound/NotFound.dart';
import '../pages/course/CourseDetail.dart';

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

var ProfileHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return Profile();
});

var CourseDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  print(parameters);
  return CourseDetail(
    id: int.parse(parameters['id']!.first),
    title: parameters['title']!.first,
  );
});
