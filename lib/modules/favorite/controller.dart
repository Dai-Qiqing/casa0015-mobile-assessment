import 'package:flutter_outfit/http/api_favorite.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetxController {
  FavoriteController();

  var apiFavorite = ApiFavorite();

  var userId;

  _initData() async {
    // 获取用户ID
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    //获取收藏列表
    await initFavorites();

    update(["favorite"]);
  }

  var favorites = [].obs;

  var favoriteIndex = 0.obs;

  var loading = true.obs;

  Future<void> initFavorites() async {
    loading.value = true;
    var result = await apiFavorite.getFavorites({
      'userId': userId,
    });
    favorites.value = result;
    loading.value = false;
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

  var editMode = false.obs;

  void toggleMode() {
    if (favorites.isEmpty) {
      return;
    }
    // 切换编辑模式
    editMode.value = !editMode.value;
    // 清空选中的收藏
    toDeleteFavorites.clear();
  }

  var toDeleteFavorites = [].obs;

  void addToDeleteFavorites(id) async {
    if (toDeleteFavorites.contains(id)) {
      toDeleteFavorites.remove(id);
      return;
    }
    toDeleteFavorites.add(id);
  }

  void deleteAllFavorites() async {
    if (favorites.isEmpty) {
      return;
    }
    // 删除所有收藏
    await apiFavorite.deleteFavorites({
      'userId': userId,
    });
    // 更新收藏列表
    favorites.clear();
    // 退出编辑模式
    toggleMode();
  }

  void deleteFavorites() async {
    if (toDeleteFavorites.isEmpty) {
      return;
    }
    // 删除选中的收藏
    await apiFavorite.deleteFavorites({
      'userId': userId,
      'ids': toDeleteFavorites,
    });
    // 更新收藏列表
    await initFavorites();
    if (favorites.isEmpty) {
      // 如果收藏列表为空，退出编辑模式
      toggleMode();
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  String formatDate(date) {
    // 格式化日期为 "dd/MM\nyyyy" 的形式
    return DateFormat('d MMM.yyyy').format(date);
  }
}
