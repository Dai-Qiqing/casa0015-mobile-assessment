import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavoriteController>();
    final l10n = AppLocalizations.of(context);
    return Obx(
      () => Visibility(
        visible: controller.editMode.value,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(50.r),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              EditButton(
                title: l10n.clearAll,
                icon: Icons.cleaning_services,
                onTap: controller.deleteAllFavorites,
              ),
              EditButton(
                title: l10n.delete,
                icon: Icons.delete,
                onTap: controller.deleteFavorites,
              ),
              EditButton(
                title: l10n.cancel,
                icon: Icons.cancel,
                onTap: controller.toggleMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
