import 'package:bird_discovery/views/auth/controllers/auth_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/auth/forget_password_screen.dart';
// import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/auth/get_started_screen.dart';
import 'package:bird_discovery/views/auth/signup_screen.dart';
import 'package:bird_discovery/views/home/widgets/bottom_nav_bar_screen.dart';
// import 'package:bird_discovery/widgets/custom_button.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:bird_discovery/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.transparent,
      //   leading: CustomIconButton(
      //     onPressed: () => Get.back(),
      //     child: Image.asset(AppImages.arrowLeft, height: 16.h),
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
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: Image.asset(AppImages.authLogo),
                      ),
                      SizedBox(height: 19.h),
                      Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 25.h),
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
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          SizedBox(
                            height: 18.h,
                            width: 18.w,
                            child: Obx(
                              () => Checkbox(
                                value: authController.isRememberMe.value,
                                onChanged: (value) {
                                  authController.toggleCheckboxRemeber();
                                  print(authController.isRememberMe.value);
                                },
                                activeColor: AppColors.primaryColor,
                                overlayColor: MaterialStateProperty.all(
                                  AppColors.primaryColor,
                                ),
                                splashRadius: 0,
                                checkColor: AppColors.whiteColor,

                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.5,
                                    color: AppColors.lightGreyColor,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Remember for 30 days',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () => Get.to(() => ForgetPasswordScreen()),
                            child: Text(
                              'Forgot password',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 31.h),
                      CustomElevatedButton(
                        isGradient: true,
                        height: 60.h,
                        onclick: () async {
                          if (authController.isLoading.value) return;
                          if (authController.validateSignin(
                            emailController.text,
                            passwordController.text,
                          )) {
                            final result = await authController.loginUser(
                              emailController.text,
                              passwordController.text,
                            );
                            if (result) {
                              Get.snackbar(
                                'Sucess',
                                'Login Successful',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.transparent,
                                colorText: Colors.black,
                              );
                              print(emailController.text);
                              print(passwordController.text);
                              Get.offAll(() => BottomNavBarScreen());
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
                                    'Sign in',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 29.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAll(() => SignupScreen());
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 23.h),
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
