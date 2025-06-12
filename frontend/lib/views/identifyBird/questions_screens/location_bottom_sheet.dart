import 'package:bird_discovery/views/identifyBird/controllers/identify_bird_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  final IdentifyBirdController identifyBirdController =
      Get.isRegistered<IdentifyBirdController>()
          ? Get.find<IdentifyBirdController>()
          : Get.put(IdentifyBirdController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5.h,
                  width: 50.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrayColor,
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 21.h),
            Text(
              'Choose a Location',
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: identifyBirdController.locationController.value,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackColor,
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.blackColor),
                filled: true,
                fillColor: AppColors.searchBarColor,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onChanged: (q) {},
            ),
            SizedBox(height: 20.h),
            Obx(
              () =>
                  identifyBirdController.locationController.value.text.isEmpty
                      ? Text(
                        'Popular Searches',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      : SizedBox.shrink(),
            ),
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: identifyBirdController.locationSearches.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      identifyBirdController.birdLocation.value =
                          identifyBirdController
                              .locationSearches[index]['city']!;
                      Get.back();
                    },
                    child: Container(
                      height: 70.h,
                      child: Column(
                        children: [
                          Divider(color: AppColors.greyColor),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.mapPin4,
                                height: 21.h,
                                color: AppColors.darkGreyColor,
                              ),
                              // Icon(
                              //   Icons.location_on,
                              //   color: AppColors.darkGreyColor,
                              // ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    identifyBirdController
                                        .locationSearches[index]['city']!,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  Text(
                                    identifyBirdController
                                        .locationSearches[index]['location']!,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
