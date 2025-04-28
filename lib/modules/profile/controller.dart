import 'package:flutter_outfit/index.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  ProfileController();

  _initData() {
    update(["profile"]);
  }

  void onTap() {}

  @override
  void onInit() async {
    super.onInit();

    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('username') ?? '默认用户';
    email.value = prefs.getString('email') ?? '';
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  final userName = ''.obs;
  final email = ''.obs;
  final avatarUrl = ''.obs;

  void logout() {
    Get.offAllNamed(AppRoutes.AUTH);
  }

  void navigateToFavorites() {
    Get.toNamed(AppRoutes.FAVORITE);
  }

  void navigateToRecord() {
    Get.toNamed(AppRoutes.RECORD);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
