import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/helper_functions.dart';
import 'package:bird_discovery/views/home/bird_analytics/controllers/bird_analytics_controller.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/description_card_overview.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/distribution_area_overview.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/food_habits_card_overview.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/overall_rarity_overview.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/quick_facts_overview.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/range_map_overview.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/rarity_card_overview.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/sound_card_overview.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<BirdAnalyticsController>();
    return Column(
      children: [
        RarityOverviewCard(
          grade: getRarityType(ctrl.birdDetails.value!.rarityType),
          description: ctrl.birdDetails.value!.rarityDesc,
        ),
        QuickFactsCard(),
        DescriptionCard(description: ctrl.birdDetails.value!.description),
        OverallRarityCard(),
        SoundSection(),
        FoodHabitsSection(),
        RangeMapsSection(),
        DistributionAreaSection(
          description: ctrl.birdDetails.value!.distributionArea,
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            CustomElevatedButton(
              isGradient: false,
              bgColor: Colors.white,
              textColor: AppColors.blackColor,
              borderColor: AppColors.greyColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              radius: 15.r,
              height: 50.h,
              width: 120.w,
              onclick: () => print('Fix Results tapped'),
              child: Text(
                'Fix Results',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: CustomElevatedButton(
                isGradient: false,
                bgColor: AppColors.secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                radius: 15.r,

                height: 50.h,
                onclick: () => print('Save To Collection tapped'),
                child: Text(
                  'Save To Collection',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
