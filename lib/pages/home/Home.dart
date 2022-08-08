import 'dart:convert';

import 'package:final_demo/pages/home/HomeCarousel.dart';
import 'package:final_demo/pages/home/HomeCourse.dart';
import 'package:final_demo/services/course/CourseService.dart';
import 'package:flutter/material.dart';
import '../../services/home/HomeService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class CarouselItem {
  int id;
  String img;
  String name;

  CarouselItem(this.id, this.img, this.name);
}

class _HomePageState extends State<HomePage> {
  List carousels = [];
  List courses = [];

  @override
  void initState() {
    super.initState();
    HomeService.getCarousels().then((value) => setState(() {
          carousels = value;
        }));
    CourseService.getCourses().then((value) => setState(() {
          courses = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
                height: 220, child: HomeCarousel(carousels: carousels)),
          ),
          SliverPadding(
            padding: EdgeInsets.all(5),
            // sliver: Container(
            //     height: 200,
            //     child: HomeCourse(
            //       courses: courses,
            //     )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
