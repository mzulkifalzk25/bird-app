import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/auth/signin_screen.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordChangeSuccessScreen extends StatelessWidget {
  const PasswordChangeSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: CustomIconButton(
            onPressed: () => Get.back(),
            child: Image.asset(AppImages.arrowLeft),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.shieldCheckFilled, height: 52.h),
            SizedBox(height: 32.h),
            Text(
              'Password Successfully Changed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Your password has been updated! You can now log in with your new password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.lightGreyColor3,
              ),
            ),
            SizedBox(height: 64.h),
            CustomElevatedButton(
              onclick: () => Get.offAll(() => SigninScreen()),
              height: 60.h,
              isGradient: true,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
