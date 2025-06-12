import 'package:bird_discovery/utils/app_colors.dart';

import 'package:bird_discovery/views/auth/controllers/auth_controller.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/auth/otp_screen.dart';
import 'package:bird_discovery/views/auth/signin_screen.dart';
import 'package:bird_discovery/views/auth/signup_screen.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:bird_discovery/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
          'Forget password',
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
              'Forget password?',
              style: TextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'enter your email address for instructions',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 32.h),
            CustomTextfield(
              controller: emailController,
              labelText: 'Email Address',
              hintText: 'example@gmail.com',
            ),
            Spacer(),
            Obx(
              () => CustomElevatedButton(
                height: 60.h,
                isGradient: true,
                onclick: () async {
                  final result = await authController.sendOTP(
                    emailController.text,
                  );
                  if (result) {
                    Get.to(() => OtpScreen(email: emailController.text));
                  }
                },
                child:
                    authController.isLoading.value
                        ? CircularProgressIndicator(color: AppColors.whiteColor)
                        : Text(
                          'Send instruction',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
            SizedBox(height: 28.h),
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.hintColor)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Text('OR'),
                ),
                Expanded(child: Divider(color: AppColors.hintColor)),
              ],
            ),
            SizedBox(height: 28.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  width: 167.w,
                  height: 60.h,
                  isGradient: false,
                  bgColor: Colors.transparent,
                  borderColor: AppColors.blackColor,
                  onclick: () => Get.offAll(() => SigninScreen()),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  width: 167.w,
                  height: 60.h,
                  isGradient: false,
                  bgColor: Colors.transparent,
                  borderColor: AppColors.blackColor,
                  onclick: () => Get.offAll(() => SignupScreen()),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
