import 'dart:async';

import 'package:bird_discovery/controllers/user_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/home/widgets/bottom_nav_bar_screen.dart';
import 'package:bird_discovery/views/onBoarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController =
      Get.isRegistered<UserController>()
          ? Get.find<UserController>()
          : Get.put(UserController());
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      if (userController.user.value != null) {
        Get.offAll(() => BottomNavBarScreen());
      } else {
        Get.off(() => OnboardingScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.linearGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 113.w,
                height: 113.h,
                child: Image.asset(
                  AppImages.splashLogo,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.white,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Bird Discovery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
