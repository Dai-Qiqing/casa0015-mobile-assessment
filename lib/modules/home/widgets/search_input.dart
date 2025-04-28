import 'package:flutter/material.dart';
import 'package:flutter_outfit/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextFormField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: l10n.searchInputTip,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.onSearchForTap,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Color(0xFFD09ECA),
                    minimumSize: Size(74.w, 32.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19.r),
                    ),
                  ),
                  child: Text(
                    l10n.searchFor,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        IconButton(
          onPressed: controller.onRecorderTap,
          icon: Icon(
            Icons.camera,
            size: 25.sp,
          ),
        ),
      ],
    );
  }
}
