import 'package:bird_discovery/views/auth/controllers/auth_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/auth/set_password_screen.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:bird_discovery/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());
  final TextEditingController otpPinController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    otpPinController.dispose();
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
          'Verify your email',
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
              'Verify your email address',
              style: TextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'enter your verification code to set password',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 32.h),
            Center(
              child: Pinput(
                controller: otpPinController,
                focusNode: focusNode,
                smsRetriever: null,
                enableSuggestions: false,
                autofillHints: null,
                focusedPinTheme: PinTheme(
                  height: 81.h,
                  width: 76.w,
                  textStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                ),
                defaultPinTheme: PinTheme(
                  height: 81.h,
                  width: 76.w,
                  textStyle: TextStyle(
                    color: AppColors.hintColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.lightGreyColor),
                  ),
                ),
              ),
            ),

            Spacer(),
            Obx(
              () => CustomElevatedButton(
                height: 60.h,
                isGradient: true,
                onclick: () async {
                  print(otpPinController.text);
                  final result = await authController.verifyOTP(
                    widget.email,
                    otpPinController.text,
                  );
                  if (result) {
                    Get.to(() => SetPasswordScreen(email: widget.email));
                  }
                },
                child:
                    authController.isLoading.value
                        ? CircularProgressIndicator(color: AppColors.whiteColor)
                        : Text(
                          'Continue',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
