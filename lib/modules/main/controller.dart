import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  MainController();

  _initData() {
    update(["main"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  var currentNavIndex = 0.obs;
  //增加一个新的变量，默认值为0
  PageController pageController = PageController(initialPage: 0);

  final mainPages = [
    const HomePage(),
    const ProfilePage(),
  ];

  void setCurrentNavIndex(index) {
    currentNavIndex.value = index;
    update();
  }

  void updatePageIndex(index) {
    pageController.jumpToPage(index);
    setCurrentNavIndex(index);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
