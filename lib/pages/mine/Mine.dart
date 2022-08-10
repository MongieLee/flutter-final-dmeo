import 'package:final_demo/providers/UserProvider.dart';
import 'package:final_demo/services/auth/AuthService.dart';
import 'package:flutter/material.dart';
import '../../utils/Global.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  double iconSize = 20;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    Map _userInfo = userProvider.userInfo;
    print(_userInfo);

    SizedBox vLine = SizedBox(
      width: 1,
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.grey[300]),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(20),
            //需要配合阴影的大小，阴影颜色
            elevation: 4,
            //阴影高度
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // side: const BorderSide(width: 3, color: Colors.pink)
            ),
            child: Column(
              children: [
                ListTile(
                  leading: _userInfo['avatar'] != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(_userInfo['avatar']),
                        )
                      : Icon(
                          Icons.account_circle,
                          size: 50,
                        ),
                  title: Text(
                    _userInfo['username'] ?? "未知",
                    style: TextStyle(fontSize: 24),
                  ),
                  subtitle: InkWell(
                    onTap: () {
                      G.router.navigateTo(context, '/profile');
                    },
                    child: Text("编辑个人资料"),
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("￥100"),
                          Text(
                            "余额",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      vLine,
                      Column(
                        children: [
                          Text("￥100"),
                          Text(
                            "余额",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      vLine,
                      Column(
                        children: [
                          Text("￥100"),
                          Text(
                            "余额",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, size: iconSize),
            trailing: Icon(Icons.arrow_forward_ios, size: iconSize),
            title: Text("设置"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help_outline, size: iconSize),
            trailing: Icon(Icons.arrow_forward_ios, size: iconSize),
            title: Text("帮助与反馈"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info_outline, size: iconSize),
            trailing: Icon(Icons.arrow_forward_ios, size: iconSize),
            title: Text("关于"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout, size: iconSize),
            trailing: Icon(Icons.arrow_forward_ios, size: iconSize),
            title: Text("注销"),
            onTap: () {
              userProvider.doLogout();
              G.router.navigateTo(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
