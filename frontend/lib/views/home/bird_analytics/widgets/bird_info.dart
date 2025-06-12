import 'package:bird_discovery/views/home/bird_analytics/controllers/bird_analytics_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BirdInfo extends StatelessWidget {
  // final List<String> images;
  const BirdInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<BirdAnalyticsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Albums',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 60.h,
          child: Obx(
            () => ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 16.w),
              itemCount: ctrl.birdDetails.value!.images.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder:
                  (_, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      ctrl.birdDetails.value!.images[i],
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
