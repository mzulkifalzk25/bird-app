import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/auth/controllers/auth_controller.dart';
import 'package:bird_discovery/views/auth/password_change_success_screen.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:bird_discovery/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email;
  const SetPasswordScreen({super.key, required this.email});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: CustomIconButton(
            onPressed: () => Get.back(),
            child: Image.asset(AppImages.arrowLeft),
          ),
        ),
        title: Text(
          'Set password',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
              'Set your password',
              style: TextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'To secure your account use 8 digit password',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 32.h),
            CustomTextfield(
              controller: passwordController,
              labelText: 'New Password',
              hintText: 'Password',
            ),
            SizedBox(height: 16.h),
            CustomTextfield(
              controller: confirmPasswordController,
              labelText: 'Confirm Password',
              hintText: 'Confirm Password',
            ),
            Spacer(),
            CustomElevatedButton(
              height: 60.h,
              isGradient: true,
              onclick: () async {
                final validatePassword = authController.validateResetPassword(
                  passwordController.text,
                  confirmPasswordController.text,
                );
                if (validatePassword) {
                  final result = await authController.resetPassword(
                    widget.email,
                    passwordController.text,
                  );
                  if (result) {
                    Get.to(() => PasswordChangeSuccessScreen());
                  }
                }
              },
              child: Text(
                'Done',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
