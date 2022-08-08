import 'package:flutter/material.dart';

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
          print(index);
        },
        child: Container(
          color: Colors.white,
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
              Expanded(flex: 3, child: Text('我是文本'))
            ],
          ),
        ),
      );
    }, childCount: widget.courses.length));
  }
}
