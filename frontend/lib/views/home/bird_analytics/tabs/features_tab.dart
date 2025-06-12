import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/views/home/bird_analytics/controllers/bird_analytics_controller.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/behavioural_traits_features.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/characteristics_card_features.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/identificiation_marker_features.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/nesting_reproduction_card_features.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeaturesTab extends StatelessWidget {
  final ctrl = Get.find<BirdAnalyticsController>();
  FeaturesTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IdentificationMarkersCard(
          markers: List.generate(
            ctrl.birdDetails.value!.identificationMarksList.length,
            (int index) {
              final text =
                  ctrl.birdDetails.value!.identificationMarksList[index];
              return IdentificationMarker(index: index + 1, text: text);
            },
          ),
          // markers: [
          //   IdentificationMarker(index: 1, text: 'Bright red plumage (male)'),
          //   IdentificationMarker(index: 2, text: 'Distinctive crest'),
          //   IdentificationMarker(index: 3, text: 'Black face mask'),
          //   IdentificationMarker(index: 4, text: 'Heavy, cone-shaped bill'),
          // ],
        ),
        PhysicalCharacteristicsCard(
          characteristics: ctrl.birdDetails.value!.physicalCharacteristics,
        ),
        BehavioralTraitsCard(
          traits: ctrl.birdDetails.value!.behavioralTaits.traits,
          seasonalAppearance:
              ctrl.birdDetails.value!.behavioralTaits.seasonalAppearance,
          diet: ctrl.birdDetails.value!.behavioralTaits.diet,
        ),
        NestingReproductionCard(
          items: ctrl.birdDetails.value!.nestingReproduction,
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
