import 'package:final_demo/providers/UserProvider.dart';
import 'package:final_demo/services/auth/AuthService.dart';
import 'package:flutter/material.dart';
import '../../utils/Global.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  double iconSize = 20;

  _lanunchUrl(_url) async {
    await canLaunch(_url) ? launch(_url) : throw '无法跳转';
  }

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
            title: Text("设置（打开地图测试）"),
            onTap: () async {
              // final availableMaps = await MapLauncher.installedMaps;
              // print(
              //     availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
              // 113.593132,22.34922
              String url = Uri.encodeFull(
                  'iosamap://viewReGeo?sourceApplication="中山大学珠海校区"&lat=22.34922&lon=113.593132&dev=0');
              print(url);
              "iosamap://navi?sourceApplication=%@&poiname=%@&lat=%@&lon=%@&dev=1";

              final availableMaps = await MapLauncher.installedMaps;
              print(
                  availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

              await availableMaps.last.showMarker(
                coords: Coords(22.34922, 113.593132),
                title: "中山大学珠海校区",
              );
              // print(await canLaunch(url));
              // await canLaunch(url) && await launch(url);
            },
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
            onTap: () {
              _lanunchUrl("http://www.baidu.com");
            },
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
