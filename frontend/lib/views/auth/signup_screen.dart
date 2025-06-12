import 'package:bird_discovery/views/auth/controllers/auth_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/auth/get_started_screen.dart';
import 'package:bird_discovery/views/auth/signin_screen.dart';
// import 'package:bird_discovery/widgets/custom_button.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:bird_discovery/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.transparent,
      //   leading: InkWell(
      //     child: Icon(Icons.arrow_back_ios),
      //     onTap: () => Get.off(() => GetStartedScreen()),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              CustomIconButton(
                padding: 15.h,
                backgroundColor: AppColors.whiteColor,
                onPressed: () => Get.off(() => GetStartedScreen()),
                child: Image.asset(AppImages.arrowLeft),
              ),
              SizedBox(height: 15.h),
              // SizedBox(height: 15.h),
              // SizedBox(height: 15.h),
              Container(
                // height: 754.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 29.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 60.h,
                            child: Image.asset(AppImages.authLogo),
                          ),
                          SizedBox(height: 19.h),
                          Text(
                            'Sign up to create account',
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Unleash your pets health with AI analyzer',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      CustomTextfield(
                        labelText: 'Full Name',
                        controller: nameController,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextfield(
                        labelText: 'Email Address',
                        controller: emailController,
                      ),
                      SizedBox(height: 15.h),
                      Obx(
                        () => CustomTextfield(
                          controller: passwordController,
                          labelText: 'Password',
                          obsecureText: authController.isPasswordObsecure.value,
                          suffixIcon: AppImages.obsecureOffIcon,
                          onSuffixIconTap:
                              () => authController.togglePasswordVisibility(),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomElevatedButton(
                        isGradient: true,
                        height: 60.h,
                        onclick: () async {
                          if (authController.isLoading.value) return;
                          if (authController.validateSignup(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          )) {
                            final result = await authController.signUpUser(
                              emailController.text,
                              nameController.text,
                              passwordController.text,
                            );
                            if (result) {
                              Get.snackbar(
                                'Sucess',
                                'Signup Successful',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.transparent,
                                colorText: Colors.black,
                              );
                              Get.off(() => SigninScreen());
                              print(emailController.text);
                              print(passwordController.text);
                            }
                          }
                        },
                        child: Obx(
                          () =>
                              authController.isLoading.value
                                  ? Container(
                                    height: 30.h,
                                    width: 30.w,
                                    child: CircularProgressIndicator(
                                      color: AppColors.whiteColor,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                  : Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 26.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.lightGreyColor,
                              thickness: 1.h,
                              // indent: 8.w,
                              // endIndent: 8.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.hintColor,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.lightGreyColor,
                              thickness: 1.h,
                              // indent: 8.w,
                              // endIndent: 8.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      CustomElevatedButton(
                        isGradient: false,
                        height: 56,
                        bgColor: Colors.transparent,
                        borderColor: AppColors.lightGreyColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.apple),
                            Image.asset(AppImages.appleIcon),
                            SizedBox(width: 7.w),
                            Text('Continue with Apple'),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomElevatedButton(
                        isGradient: false,
                        height: 56,
                        bgColor: Colors.transparent,
                        borderColor: AppColors.lightGreyColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.apple),
                            Image.asset(AppImages.googleIcon),
                            SizedBox(width: 7.w),
                            Text('Continue with Google'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
