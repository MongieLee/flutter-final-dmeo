import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/CurrentIndexProvider.dart';
import 'home/Home.dart';
import 'study/Study.dart';
import 'mine/Mine.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: '首页', backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.message), label: '学习', backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), label: '我', backgroundColor: Colors.red),
  ];

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

    return Scaffold(
      appBar: pages[currentIndex]['appBar'],
      body: pages[currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        onTap: (index) {
          provider.changeIndex(index);
        },
      ),
    );
  }
}