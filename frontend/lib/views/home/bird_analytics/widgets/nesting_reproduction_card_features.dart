import 'package:bird_discovery/views/home/bird_analytics/models/bird_analytics_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';

class NestingReproductionItem {
  final Color bulletColor;
  final String text;
  NestingReproductionItem({required this.bulletColor, required this.text});
}

class NestingReproductionCard extends StatelessWidget {
  final NestingReproductionModel items;

  const NestingReproductionCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Nesting & Reproduction',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),

          SizedBox(height: 12.h),

          // Each bullet item
          nestingRow(
            title: 'Breeding season:',
            color: AppColors.greenColor,
            value: items.breedingSeason,
          ),
          nestingRow(
            title: 'Nest:',
            color: AppColors.lightPurpleIcon,
            value: items.nest,
          ),
          nestingRow(
            title: 'Eggs:',
            color: AppColors.lightBlueIcon,
            value: items.eggs,
          ),
          nestingRow(
            title: 'Fledging:',
            color: AppColors.lightYellowIcon,
            value: items.fledging,
          ),
        ],
      ),
    );
  }

  Widget nestingRow({
    required String title,
    required Color color,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // colored bullet circle
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 16.w),

          // text
          Expanded(
            child: Text(
              '${title} ${value}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
