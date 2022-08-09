import 'package:final_demo/providers/UserProvider.dart';
import 'package:final_demo/services/auth/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/Global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class UserForm {
  String username = 'admin';
  String password = '123';
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserForm userForm = UserForm();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("用户登录"),
        ),
        body: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(hintText: "请输入手机号"),
                        validator: (value) {
                          return value!.isEmpty ? '手机号不能为空' : null;
                        },
                        onSaved: (value) {
                          userForm.username = value!;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(hintText: "请输入密码"),
                        validator: (value) {
                          return value!.isEmpty ? '密码不能为空' : null;
                        },
                        onSaved: (value) {
                          userForm.password = value!;
                        },
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  var res = await AuthService.login(
                                      username: userForm.username,
                                      password: userForm.password);
                                  if (res != null) {
                                    G.router.pop(context);
                                    userProvider.doLogin(res);
                                  } else {
                                    _formKey.currentState!.reset();
                                  }
                                }
                              },
                              child: const Text('登录')))
                    ],
                  ))
            ]))));
  }
}
