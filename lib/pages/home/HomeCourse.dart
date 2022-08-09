import 'package:flutter/material.dart';
import '../../utils/Global.dart';

class HomeCourse extends StatefulWidget {
  List courses = [];

  HomeCourse({Key? key, required this.courses}) : super(key: key);

  @override
  State<HomeCourse> createState() => _HomeCourseState();
}

class _HomeCourseState extends State<HomeCourse> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      var item = widget.courses[index];
      return GestureDetector(
        onTap: () {
          Map<String, dynamic> p = {'id': item['id'], 'title': item['name']};
          print("/courseDetail${G.parseQuery(p)}");
          // path=/courseDetail?a=1&b=2
          G.router.navigateTo(context, "/courseDetail${G.parseQuery(p)}");
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item["img"],
                      fit: BoxFit.cover,
                      height: 120,
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            item['name'],
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            item['name'] + '大数据开发了速度加快立法老师的课解放昆仑山搭街坊看待历史交锋的',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(children: [
                          Container(
                            child: Text(
                              item['name'],
                              style: const TextStyle(fontSize: 16),
                            ),
                            color: Colors.grey[200],
                            padding: const EdgeInsets.all(5),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              item['name'],
                              style: const TextStyle(fontSize: 16),
                            ),
                            color: Colors.grey[200],
                            padding: const EdgeInsets.all(5),
                          ),
                        ]),
                        Row(children: [
                          const Text(
                            '￥200',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              '100份',
                              style: TextStyle(fontSize: 14),
                            ),
                            padding: const EdgeInsets.all(5),
                          ),
                        ]),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
    }, childCount: widget.courses.length));
  }
}
