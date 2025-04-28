import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecordPage extends GetView<RecordController> {
  const RecordPage({super.key});

  // 主视图
  Widget _buildView(context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      height: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorValue.gradientStart,
            ColorValue.gradientCenter,
            ColorValue.gradientEnd,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : controller.records.isEmpty
              ? Center(
                  child: Text(
                    l10n.emptyTip,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              : Column(
                  children: [
                    RecordList(),
                    SizedBox(height: 25.h),
                    DateList(),
                  ],
                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordController>(
      init: RecordController(),
      id: "record",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Records"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Obx(
              () => _buildView(context),
            ),
          ),
        );
      },
    );
  }
}
