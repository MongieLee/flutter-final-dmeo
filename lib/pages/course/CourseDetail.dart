import 'package:final_demo/services/course/CourseService.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

class CourseDetail extends StatefulWidget {
  int id;
  String title;

  CourseDetail({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class CourseEntity {
  int id = 0;
  String title = '';
  String imagePath = '';
}

class _CourseDetailState extends State<CourseDetail> {
  CourseEntity courseDetail = CourseEntity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            courseDetail.imagePath.isNotEmpty
                ? Image.network(
                    courseDetail.imagePath,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.yellow, width: 10))),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "这是一条非常劲爆的消息详情",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    '这是灰色的子标题',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "￥2000",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "￥188999",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                      Text("100台已购"),
                    ],
                  ),
                  // Html(
                  //   data: '<div>123</div>',
                  // )
                ],
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    CourseService.getDetailById(widget.id).then((value) {
      print(value);
      setState(() {
        courseDetail.title = value['title'];
        courseDetail.id = value['id'];
        courseDetail.imagePath = value['imagePath'];
      });
    });
  }
}
