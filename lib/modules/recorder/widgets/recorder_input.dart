import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecorderInput extends StatelessWidget {
  const RecorderInput({
    super.key,
    required this.controller,
    required this.tip,
    required this.label,
  });

  final dynamic controller;
  final dynamic tip;
  final dynamic label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: tip,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      style: TextStyle(fontSize: 15.sp),
    );
  }
}
