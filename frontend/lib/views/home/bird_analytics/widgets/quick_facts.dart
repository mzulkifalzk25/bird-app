import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/home/bird_analytics/controllers/bird_analytics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuickFactsSection extends StatelessWidget {
  const QuickFactsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<BirdAnalyticsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Facts',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Column
            Expanded(
              child: Column(
                children: [
                  _buildFactItem(
                    icon: AppImages.leastFacts,
                    //color: const Color(0xFF4CAF50),
                    color: AppColors.leastColor,
                    title: 'Conservation',
                    value: ctrl.birdDetails.value!.quickFacts[0],
                  ),
                  SizedBox(height: 16.h),
                  _buildFactItem(
                    icon: AppImages.calenderIcon3,
                    //color: const Color(0xFF2196F3),
                    color: AppColors.seasonColor,
                    title: 'Season',
                    value: ctrl.birdDetails.value!.quickFacts[1],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Second Column
            Expanded(
              child: Column(
                children: [
                  _buildFactItem(
                    icon: AppImages.habitatFacts,
                    //color: const Color(0xFFFF9800),
                    title: 'Habitat',
                    value: ctrl.birdDetails.value!.quickFacts[2],
                    color: AppColors.habitateColor,
                  ),
                  SizedBox(height: 16.h),
                  _buildFactItem(
                    icon: AppImages.commonFacts,
                    //color: const Color(0xFF9C27B0),
                    color: AppColors.sightingsColor,
                    title: 'Sightings',
                    value: ctrl.birdDetails.value!.quickFacts[3],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFactItem({
    required String icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon in colored circle
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(
            child: Image.asset(
              icon,
              width: 20.w,
              height: 20.h,
              // color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.blackColor.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
