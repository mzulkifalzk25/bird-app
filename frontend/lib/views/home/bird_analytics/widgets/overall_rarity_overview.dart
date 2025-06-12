// lib/views/home/bird_analytics/widgets/overall_rarity_card.dart

import 'package:bird_discovery/views/home/bird_analytics/models/bird_analytics_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/bird_analytics_controller.dart';
import '../../../../controllers/collection_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';

class OverallRarityCard extends StatelessWidget {
  const OverallRarityCard({super.key});

  LinearGradient _badgeGradient(String grade) {
    switch (grade) {
      case 'A':
        return AppColors.aGradeGradient;
      case 'B':
        return AppColors.bGradeGradient;
      case 'C':
        return AppColors.cGradeGradient;
      case 'D':
        return AppColors.dGradeGradient;
      case 'S':
        return AppColors.sGradeGradient;
      default:
        return AppColors.sGradeGradient;
    }
  }

  Widget _buildRow(OverallRarityModel item) {
    if (item.label == 'Overall Significance') {
      // Overall Significance row
      return Column(
        children: [
          Divider(color: AppColors.lightGreyColor, thickness: 1),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Container(
                width: 50.w,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: _badgeGradient(item.rarity),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.rarity,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Normal rows
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
              maxLines: 2,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 4,
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
              maxLines: 2,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              gradient: _badgeGradient(item.rarity),
              // borderRadius: BorderRadius.circular(12.r),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              item.rarity,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final ctrl =
    //     Get.isRegistered<CollectionController>()
    //         ? Get.find<CollectionController>()
    //         : Get.put<CollectionController>(CollectionController());
    final ctrl = Get.find<BirdAnalyticsController>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Image.asset(AppImages.graphIcon, width: 20.w, height: 20.w),
              SizedBox(width: 8.w),
              Text(
                'Overall Rarity',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Detail rows
          ...ctrl.birdDetails.value!.overallRarityList.map(_buildRow),

          // Overall Significance row
          // _buildRow(ctr.birdDetails.value.overallRarityList),
        ],
      ),
    );
  }
}
