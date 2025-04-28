import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecordList extends StatelessWidget {
  const RecordList({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RecordController>();
    var sliderController = CarouselSliderController();
    return Obx(
      () => CarouselSlider(
        items: List.generate(
          controller.records.length,
          (i) => RecordItem(
            item: controller.records[i],
          ),
        ).toList(),
        carouselController: sliderController,
        options: CarouselOptions(
          viewportFraction: 1,
          height: 579.h,
        ),
      ),
    );
  }
}
