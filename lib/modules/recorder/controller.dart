import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecorderController extends GetxController {
  RecorderController();

  var apiOutfit = ApiOutfit();

  _initData() {
    update(["recorder"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();

    initCamera();
  }

  var loading = true.obs;

  late List<CameraDescription> cameras;
  late CameraController cameralController;
  late CameraLensDirection currentCamera;
  var cameraBack = true.obs;

  void initCamera() async {
    cameras = await availableCameras();
    cameraBack.value = true;
    // 默认使用后置摄像头
    cameralController = CameraController(
      cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      ),
      ResolutionPreset.medium,
    );
    await cameralController.initialize();

    loading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  var image;
  var loadPicture = false.obs;

  void saveOutfit() async {
    final l10n = AppLocalizations.of(Get.context!);
    final name = nameController.text;
    final description = descriptionController.text;
    final category = categoryController.text;
    if (name.isEmpty || description.isEmpty || category.isEmpty) {
      Get.snackbar(l10n.titleTip, l10n.recorderInputTip);
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await apiOutfit.addOutfit(
      {
        'userId': prefs.getInt('userId'),
        'name': nameController.text,
        'description': descriptionController.text,
        'category': categoryController.text,
      },
      image,
    );

    loadPicture.value = false;

    nameController.clear();
    descriptionController.clear();
    categoryController.clear();

    Get.back();
  }

  final ImagePicker picker = ImagePicker();

  void selectFile() async {
    // 1. 获取图片文件
    image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    loadPicture.value = true;
  }

  void takePhoto() async {
    // 1. 拍照并获取图片文件
    image = await cameralController.takePicture();

    loadPicture.value = true;
  }

  void flipCamera() async {
    loadPicture.value = false;
    loading.value = true;
    // 更新当前摄像头为新的摄像头
    cameraBack.value = !cameraBack.value;
    final newCamera = cameras.firstWhere(
      (camera) =>
          camera.lensDirection ==
          (cameraBack.value
              ? CameraLensDirection.back
              : CameraLensDirection.front),
    );

    // 释放当前的相机控制器
    await cameralController.dispose();

    // 切换到新的摄像头
    cameralController = CameraController(newCamera, ResolutionPreset.medium);

    // 初始化新的相机
    await cameralController.initialize();

    loading.value = false;
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    cameralController.dispose();

    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
  }
}
