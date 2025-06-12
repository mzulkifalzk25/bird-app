import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/home/voice_identifier/bird_photo_screen.dart';
import 'package:bird_discovery/views/home/voice_identifier/voice_identifier_screen.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IndentifyOptionsBottomSheet extends StatelessWidget {
  const IndentifyOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 251.h,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5.h,
              width: 35.w,
              decoration: BoxDecoration(
                color: AppColors.bottomnavbarGrey,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
          SizedBox(height: 25.h),
          Text(
            'Choose the how to identify',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15.h),
          CustomElevatedButton(
            height: 60.h,
            isGradient: false,
            bgColor: AppColors.searchBarColor,
            onclick: () {
              Get.back();
              Get.to(() => BirdPhotoScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.pictureIcon, width: 16.w),
                SizedBox(width: 8.w),
                Text(
                  'Identify By Photo',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          CustomElevatedButton(
            height: 60.h,
            isGradient: false,
            bgColor: AppColors.searchBarColor,
            onclick: () {
              Get.back();
              Get.to(() => BirdSoundScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.waveIcon,
                  width: 16.w,
                  color: AppColors.black,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Identify By Sound',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
