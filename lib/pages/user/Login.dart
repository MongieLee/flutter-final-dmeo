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
                        decoration: InputDecoration(hintText: "请输入手机号"),
                        validator: (value) {
                          // RegExp reg = new RegExp(r'^\d{11}$');
                          // if (!reg.hasMatch(value!)) {
                          //   return "手机号不对";
                          // }
                          return null;
                        },
                        onSaved: (value) {
                          print('onSaved');
                          userForm.username = value!;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "请输入密码"),
                        validator: (value) {
                          return value!.length < 3 ? '长度太短了' : null;
                        },
                        onSaved: (value) {
                          print('passowrd onSaved');
                          userForm.password = value!;
                        },
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print('提交成功');
                              print('_formKey.currentState!.save() -- before');
                              _formKey.currentState!.save();
                              print('_formKey.currentState!.save() -- after');
                              print(userForm.username);
                              print(userForm.password);
                              var res = await AuthService.login(
                                  username: userForm.username,
                                  password: userForm.password);
                              print(res);
                              if (res != null) {
                                //登陆成功
                                G.router.pop(context);
                                userProvider.doLogin(res);
                              } else {
                                print("登陆失败了");
                                _formKey.currentState!.reset();
                              }
                            }
                          },
                          child: Text('登录')),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.reset();
                          },
                          child: Text('重置')),
                    ],
                  ))
            ]))));
  }
}
