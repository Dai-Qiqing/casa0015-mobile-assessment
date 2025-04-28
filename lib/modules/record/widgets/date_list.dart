import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DateList extends StatefulWidget {
  const DateList({super.key});

  @override
  State<DateList> createState() => _DateListState();
}

class _DateListState extends State<DateList> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RecordController>();
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.dates.length,
        itemBuilder: (context, index) {
          return Obx(
            () => Container(
              width: 60.w,
              height: 50.h,
              margin: EdgeInsets.only(right: 15.w),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: controller.dateIndex.value == index
                    ? const Color(0xFFD09ECA)
                    : const Color(0xCCFFFFFF),
              ),
              child: TextButton(
                child: Text(
                  controller.formatDate(controller.dates[index]),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: controller.dateIndex.value == index
                        ? Colors.white
                        : Color(0xFFD09ECA),
                  ),
                ),
                onPressed: () => controller.onDateItemTap(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
