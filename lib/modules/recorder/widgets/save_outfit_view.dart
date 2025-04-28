import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SaveOutfitView extends StatelessWidget {
  const SaveOutfitView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RecorderController>();
    final l10n = AppLocalizations.of(context);
    return Container(
      height: 400.h,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 20.h,
      ),
      child: Column(
        children: [
          Text(
            l10n.recorderTitle,
            style: TextStyle(
              color: ColorValue.primary,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40.h),
          RecorderInput(
            controller: controller.nameController,
            tip: l10n.recorderInputTip,
            label: l10n.recorderName,
          ),
          SizedBox(height: 10.h),
          RecorderInput(
            controller: controller.descriptionController,
            tip: l10n.recorderInputTip,
            label: l10n.recorderDescription,
          ),
          SizedBox(height: 10.h),
          RecorderInput(
            controller: controller.categoryController,
            tip: l10n.recorderInputTip,
            label: l10n.recorderCategory,
          ),
          SizedBox(height: 40.h),
          ElevatedButton(
            onPressed: controller.saveOutfit,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(0),
              backgroundColor: Color(0xFFD09ECA),
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              l10n.saveOutfit,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
