import 'dart:convert';

import 'package:flutter/material.dart';
import '../../services/auth/AuthService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('首页'),
        OutlinedButton(
            onPressed: () async {
              var res = await AuthService.login();
              print('res');
              print(res);
            },
            child: Text('登录测试'))
      ],
    );
  }
}
