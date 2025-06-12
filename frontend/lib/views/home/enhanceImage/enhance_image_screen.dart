import 'dart:io';

import 'package:bird_discovery/controllers/capture_image_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/home/bird_analytics/bird_analytics_screen.dart';
import 'package:bird_discovery/views/home/enhanceImage/capture_image_screen.dart';
import 'package:bird_discovery/views/home/home_screen.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:camera/camera.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EnhanceImageScreen extends StatefulWidget {
  const EnhanceImageScreen({super.key});

  @override
  State<EnhanceImageScreen> createState() => _EnhanceImageScreenState();
}

class _EnhanceImageScreenState extends State<EnhanceImageScreen> {
  final CaptureImageController controller =
      Get.isRegistered<CaptureImageController>()
          ? Get.find<CaptureImageController>()
          : Get.put(CaptureImageController());

  @override
  Widget build(BuildContext context) {
    print('0000000000000000000000000000000000000');
    print(controller.picture.value.path);
    final picture = controller.picture.value;
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Expanded(child: Image.file(File(picture.path))),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomIconButton(
                      onPressed: () => Get.back(),
                      child: Image.asset(
                        AppImages.close,
                        width: 16.w,
                        color: AppColors.black,
                      ),
                    ),
                    Spacer(),
                    CustomIconButton(
                      child: Image.asset(
                        AppImages.searchIcon,
                        width: 16.w,
                        color: AppColors.black,
                      ),
                      // onPressed: () => Get.back(),
                      // child: Icon(
                      //   Icons.share_arrival_time,
                      //   color: AppColors.blackColor,
                      // ),
                    ),
                    CustomIconButton(
                      // onPressed: () => Get.back(),
                      child: Image.asset(
                        AppImages.shareIcon,
                        width: 16.w,
                        color: AppColors.black,
                      ),
                      // child: Icon(Icons.share, color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Zoom & Drag the frame your\nbird within the square',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 15.sp,

                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 26.h),
              Container(
                height: 116.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  color: AppColors.whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 31.h,
                    horizontal: 10.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomElevatedButton(
                        onclick: () => Get.off(() => CaptureImageScreen()),
                        width: 110.w,
                        height: 58.h,
                        isGradient: false,
                        bgColor: AppColors.lightGreyColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.retakeIcon,
                              width: 16.w,
                              color: AppColors.black,
                            ),
                            // Icon(Icons.camera_alt, color: AppColors.blackColor),
                            SizedBox(width: 5.w),
                            Text('Retake'),
                          ],
                        ),
                      ),
                      CustomElevatedButton(
                        onclick: () async {
                          await controller.savePicture();
                        },
                        width: 110.w,
                        height: 58.h,
                        bgColor: AppColors.lightGreyColor,
                        isGradient: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.saveIcon,
                              width: 16.w,
                              color: AppColors.black,
                            ),
                            // Icon(Icons.save_alt, color: AppColors.blackColor),
                            SizedBox(width: 5.w),
                            Text('Save'),
                          ],
                        ),
                      ),
                      CustomElevatedButton(
                        onclick: () => Get.to(() => BirdAnalyticsScreen()),
                        width: 110.w,
                        height: 58.h,
                        isGradient: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.scanIcon,
                              width: 16.w,
                              color: AppColors.whiteColor,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Identify',
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
