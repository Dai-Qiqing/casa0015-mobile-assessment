import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecorderPage extends GetView<RecorderController> {
  const RecorderPage({super.key});

  void showSaveOutfitDialog(context) {
    Get.bottomSheet(
      SaveOutfitView(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
    );
  }

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
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.loadPicture.value
                    ? Container(
                        width: 303.w,
                        height: 426.h,
                        margin: EdgeInsets.only(
                          bottom: 50.h,
                        ),
                        child: Image.file(
                          File(controller.image.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 317.w,
                        height: 440.h,
                        margin: EdgeInsets.only(
                          bottom: 50.h,
                        ),
                        child: CameraPreview(
                          controller.cameralController,
                        ),
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RecorderButton(
                      title: l10n.album,
                      icon: 'assets/album.png',
                      onTap: controller.selectFile,
                    ),
                    GestureDetector(
                      onTap: controller.takePhoto,
                      child: Image.asset(
                        'assets/camera.png',
                        width: 80.w,
                        height: 80.h,
                      ),
                    ),
                    RecorderButton(
                      title: l10n.flip,
                      icon: 'assets/flip.png',
                      onTap: controller.flipCamera,
                    ),
                  ],
                )
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GetBuilder<RecorderController>(
      init: RecorderController(),
      id: "recorder",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Recorder"),
            centerTitle: true,
            actions: [
              Obx(
                () => Visibility(
                  visible: controller.loadPicture.value,
                  child: Container(
                    height: 26.h,
                    margin: EdgeInsets.only(right: 10.w),
                    child: TextButton(
                      onPressed: () => showSaveOutfitDialog(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Color(0xFFD09ECA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
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
                  ),
                ),
              ),
            ],
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
