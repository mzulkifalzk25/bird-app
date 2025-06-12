import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/home/bird_analytics/bird_analytics_screen.dart';
import 'package:bird_discovery/views/identifyBird/controllers/identify_bird_controller.dart';
import 'package:bird_discovery/views/identifyBird/widgets/bird_item.dart';
import 'package:bird_discovery/views/identifyBird/widgets/chat_bubble.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';

class SimilarIdentificationScreen extends StatelessWidget {
  const SimilarIdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IdentifyBirdController ctrl = Get.find<IdentifyBirdController>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(left: 16.w),
          height: 48.h,
          child: CustomIconButton(
            onPressed: () => Get.back(),
            child: Image.asset(AppImages.arrowLeft, height: 16.h),
          ),
        ),
        title: Text(
          'Ask BirdBrain',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              height: 48.h,
              child: CustomIconButton(
                padding: 15.w,
                child: Image.asset(AppImages.moreHorzIcon, width: 10.h),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            // Bird List Section
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ctrl.birdList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0.w,
                      vertical: 6.h,
                    ),
                    child: BirdItem(
                      birdName: ctrl.birdList[index].name,
                      birdScientificName: ctrl.birdList[index].scientificName,
                      onTap: () {
                        Get.to(() => BirdAnalyticsScreen());
                        // Handle Bird Details
                      },
                      imageUrl: ctrl.birdList[index].imageUrl,
                    ),
                  );
                },
              ),
            ),

            // "Try Again" Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: CustomButton(
                text: "Try Again",
                isGradient: false,
                textColor: AppColors.secondaryColor,
                fontSize: 16.sp,
                bgColor: AppColors.whiteColor,
                borderColor: AppColors.secondaryColor,
                fontWeight: FontWeight.w600,
                width: double.infinity,
                height: 54.h,
                onclick: () {
                  ctrl.retryBirds();
                },
              ),
            ),

            // Chat Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Obx(
                () => Stack(
                  children: [
                    ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ctrl.chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = ctrl.chatMessages[index];
                        return ChatBubble(
                          message: message.text,
                          isSender: message.isSender,
                        );
                      },
                    ),

                    // Loading indicator overlay
                    if (ctrl.isChatLoading.value)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15.w,
                                backgroundImage: AssetImage(AppImages.birdLOGO),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 16.w,
                                      height: 16.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              AppColors.primaryColor,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Thinking...',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12.sp,
                                      ),
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
              ),
            ),

            // Input Section
          ],
        );
      }),
      bottomNavigationBar: Container(
        height: 108.h,
        color: AppColors.mediumBlueColor,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
        child: Row(
          children: [
            // Input field
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: TextField(
                  controller: ctrl.chatController,
                  decoration: InputDecoration(
                    hintText: 'Type message...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),
                  onSubmitted: (value) => ctrl.sendChatMessage(value),
                ),
              ),
            ),

            // Send button
            SizedBox(width: 10.w),
            Obx(
              () => GestureDetector(
                onTap:
                    ctrl.isChatLoading.value
                        ? null
                        : () => ctrl.sendChatMessage(ctrl.chatController.text),
                child: Container(
                  height: 44.h,
                  width: 44.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    gradient:
                        ctrl.isChatLoading.value
                            ? null
                            : AppColors.linearGradient,
                    color: ctrl.isChatLoading.value ? Colors.grey : null,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppImages.sendIcon,
                    height: 17.h,
                    width: 17.w,
                    color: Colors.white,
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
