import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  HomeController();

  var userId;

  _initData() async {
    // 获取用户ID
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');

    initRecommendations();

    update(["home"]);
  }

  void onTap() {}

  var apiOutfit = ApiOutfit();
  var apiFavorite = ApiFavorite();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  final searchController = TextEditingController();

  // 检索关键字
  var searchText = ''.obs;

  // 推荐搭配索引
  var recommendationIndex = 0.obs;
  // 推荐搭配列表
  var recommendations = [].obs;

  Future<void> initRecommendations() async {
    var result = await apiOutfit.getRecommendations({
      'userId': userId,
    });
    recommendations.value = result ?? [];
  }

  void onSearchForTap() async {
    searchText.value = searchController.text;
    var result = await apiOutfit.getOutfits({
      'userId': userId,
      'key': searchText.value,
    });
    recommendations.value = result ?? [];
  }

  void onRecorderTap() {
    Get.toNamed(AppRoutes.RECORDER);
  }

  void onRecommendationItemTap(item) async {
    await apiOutfit.updateOutfitViews({
      'outfitId': item.id,
    });
  }

  void onFavoriteTap(item) async {
    await apiFavorite.addFavorite({
      'userId': userId,
      'outfitId': item.id,
    });

    await initRecommendations();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
