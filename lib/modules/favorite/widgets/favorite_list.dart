import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:get/get.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavoriteController>();
    return Obx(
      () => ListView.builder(
        itemCount: controller.favorites.length,
        itemBuilder: (context, index) {
          return FavoriteItem(
            item: controller.favorites[index],
          );
        },
      ),
    );
  }
}
