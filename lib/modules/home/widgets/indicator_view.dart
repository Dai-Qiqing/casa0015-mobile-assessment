import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IndicatorView extends StatelessWidget {
  const IndicatorView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.recommendations.length,
          (i) => Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(5.r),
              ),
              child: Container(
                color: controller.recommendationIndex.value == i
                    ? Colors.white
                    : Colors.black12,
                width: 25.w,
                height: 10.h,
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
