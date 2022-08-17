import 'package:final_demo/services/auth/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/CurrentIndexProvider.dart';
import '../providers/UserProvider.dart';
import '../utils/Global.dart';
import 'home/Home.dart';
import 'study/Study.dart';
import 'mine/Mine.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late PageController _pageController;
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: '首页', backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.message), label: '学习', backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), label: '我', backgroundColor: Colors.red),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
        initialPage:
            G.getCurrentContext().watch<CurrentIndexProvider>().currentIndex);
  }

  final List pages = [
    {
      'page': HomePage(),
      'appBar': AppBar(
        title: const Text("首页"),
        centerTitle: true,
        elevation: 0,
      ),
    },
    {
      'page': StudyPage(),
      'appBar': AppBar(
        title: const Text("学习中心"),
        centerTitle: true,
        elevation: 0,
      ),
    },
    {
      'page': MinePage(),
      'appBar': AppBar(
        title: const Text("个人中心"),
        centerTitle: true,
        elevation: 0,
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    CurrentIndexProvider provider = Provider.of<CurrentIndexProvider>(context);
    int currentIndex = provider.currentIndex;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isLogin = userProvider.isLogin;

    return Scaffold(
      appBar: pages[currentIndex]['appBar'],
      // body: pages[currentIndex]['page'],
      body: PageView(
        controller: _pageController,
        children: pages.map<Widget>((e) => e['page']).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        onTap: (index) async {
          if ([1, 2].contains(index)) {
            if (!isLogin) {
              print('应该要登陆的');
              G.router.navigateTo(context, '/login');
              return;
            } else {
              if (userProvider.userInfo.isEmpty) {
                print('还没有用户信息，需要请求');
                Map userInfo = await AuthService.getUserInfo();
                userProvider.setUserInfo = userInfo;
              } else {
                print('已经有用户信息不用请求了');
              }
            }
          }
          provider.changeIndex(index);
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
