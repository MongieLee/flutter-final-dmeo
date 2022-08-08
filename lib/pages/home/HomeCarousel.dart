import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'Home.dart' show CarouselItem;

class HomeCarousel extends StatelessWidget {
  List carousels = [];

  HomeCarousel({Key? key, required this.carousels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return carousels.isNotEmpty
        ? SizedBox(
            height: 200,
            child: Swiper(
              itemCount: carousels.length,
              pagination: const SwiperPagination(),
//轮播图的知识点
              control: const SwiperControl(),
//左右箭头导航
              itemBuilder: (context, index) {
                return Image.network(
                  carousels[index]['img'],
                  fit: BoxFit.cover,
                );
              },
              viewportFraction: 0.7,
//图片占屏幕宽度
              scale: 0.7,
//非主图的缩小比例
              itemWidth: 400,
//宽度
              layout: SwiperLayout.STACK, //布局形式
// layout: SwiperLayout.TINDER, //需要设置item的高度和宽度才不会报错
            ))
        : Container();
  }
}
