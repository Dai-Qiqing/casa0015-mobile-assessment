import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:get/get.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  // 主视图
  Widget _buildView() {
    return Center(
      child: PageView(
        controller: controller.pageController,
        onPageChanged: controller.setCurrentNavIndex,
        children: controller.mainPages,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      id: "main",
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: _buildView(),
          ),
          bottomNavigationBar: Obx(
            () {
              final l10n = AppLocalizations.of(context);
              return BottomNavigationBar(
                fixedColor: Colors.pinkAccent,
                currentIndex: controller.currentNavIndex.value,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  controller.setCurrentNavIndex(index);
                  controller.updatePageIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: l10n.home,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: l10n.profile,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
