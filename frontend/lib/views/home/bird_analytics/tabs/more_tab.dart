import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/classificiation_item_more.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/conservation_reminder_more_widget.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/did_you_know_more.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/similar_species_more.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/bird_analytics_controller.dart';

class MoreTab extends StatelessWidget {
  final ctrl = Get.find<BirdAnalyticsController>();
  MoreTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConservationRemindersCard(
          reminders: List.generate(
            ctrl.birdDetails.value!.conservationReminders.length,
            (index) {
              final detial =
                  ctrl.birdDetails.value!.conservationReminders[index];
              return ConservationReminder(
                title: detial.title,
                body: detial.description,
              );
            },
          ),
        ),

        SizedBox(height: 20.h),
        ScientificClassificationCard(
          items: List.generate(
            ctrl.birdDetails.value!.scientificClassification.length,
            (index) {
              final detail =
                  ctrl.birdDetails.value!.scientificClassification[index];
              return ClassificationItem(
                label: detail.title,
                value: detail.description,
              );
            },
          ),
          onLearnMore: () {},
        ),
        SizedBox(height: 20.h),
        SimilarSpeciesSection(
          subtitle: 'Often perches on wires, posts, and low branches',
          species: List.generate(
            ctrl.birdDetails.value!.similarSpeciesList.length,
            (index) {
              final specie = ctrl.birdDetails.value!.similarSpeciesList[index];
              return SimilarSpecies(
                imageUrl: specie.image,
                commonName: specie.name,
                scientificName: specie.scientificName,
                note: specie.description,
              );
            },
          ),
          // species: [
          //   SimilarSpecies(
          //     imageUrl: AppImages.bird1,
          //     commonName: 'Mountain Bluebird',
          //     scientificName: 'Sialia currucoides',
          //     note: 'Lighter, sky-blue coloration with no rusty breast',
          //   ),
          //   SimilarSpecies(
          //     imageUrl: AppImages.bird2,
          //     commonName: 'Indigo Bunting',
          //     scientificName: 'Passerina cyanea',
          //     note: 'Brighter blue with distinct wing bars',
          //   ),
          // ],
        ),
        SizedBox(height: 20.h),
        DidYouKnowCard(factText: ctrl.birdDetails.value!.facts),
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
