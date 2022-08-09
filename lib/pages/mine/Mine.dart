import 'package:final_demo/services/auth/AuthService.dart';
import 'package:flutter/material.dart';
import '../../utils/Global.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              G.router.navigateTo(context, '/login');
            },
            child: Text('去登录页')),
        Text('我的'),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    AuthService.getUserInfo().then((value) {
      print(value);
    });
  }
}
