import 'package:flutter/material.dart';

import '../../utils/Global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              G.router.pop(context);
            },
            child: Text('返回')),
        TextButton(
            onPressed: () {
              G.router.navigateTo(context, '/mine');
            },
            child: Text('返回'))
      ],
    );
  }
}
