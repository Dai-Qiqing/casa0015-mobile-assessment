import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecommendationsItem extends StatelessWidget {
  const RecommendationsItem({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return GestureDetector(
      onTap: () => controller.onRecommendationItemTap(item),
      child: Container(
        width: 302.w,
        height: 469.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15.r,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15.r),
                    ),
                    child: Image.network(
                      item.picture!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 302.w,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 20.h,
                  ),
                  child: Text(
                    item.description!,
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 5.w,
              child: IconButton(
                onPressed: () => controller.onFavoriteTap(item),
                icon: Icon(
                  item.favorite == 1 ? Icons.favorite : Icons.favorite_border,
                  size: 40.r,
                  color: item.favorite == 1 ? ColorValue.primary : Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
