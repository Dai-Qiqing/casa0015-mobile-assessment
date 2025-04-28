import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavoriteController>();
    return Obx(
      () => Container(
        width: 359.w,
        height: 318.h,
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.r),
                ),
                child: Image.network(
                  item.picture!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 346.w,
                    height: 296.h,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: controller.editMode.value,
              child: Positioned(
                right: 5.w,
                top: 5.h,
                child: IconButton(
                    icon: Icon(
                      controller.toDeleteFavorites.contains(item.id)
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: controller.toDeleteFavorites.contains(item.id)
                          ? ColorValue.primary
                          : Colors.brown,
                      size: 30.sp,
                    ),
                    onPressed: () => controller.addToDeleteFavorites(item.id)),
              ),
            ),
            Positioned(
              left: 20.w,
              bottom: 25.h,
              child: Container(
                width: 213.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 15.h,
                ),
                decoration: BoxDecoration(
                  color: Color(0xB3EBA7E2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.formatDate(item.updateAt),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      item.description,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
