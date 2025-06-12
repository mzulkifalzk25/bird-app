import 'package:bird_discovery/views/home/bird_analytics/controllers/bird_analytics_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/utils/app_images.dart';
import 'package:bird_discovery/views/home/bird_analytics/share_my_find_screen.dart';
import 'package:bird_discovery/views/home/bird_analytics/tabs/features_tab.dart';
import 'package:bird_discovery/views/home/bird_analytics/tabs/more_tab.dart';
import 'package:bird_discovery/views/home/bird_analytics/tabs/overview_tab.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/bird_info.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/bird_details_section.dart';
import 'package:bird_discovery/views/home/bird_analytics/widgets/sound_card_overview.dart';
import 'package:bird_discovery/widgets/custom_elevated_button.dart';
import 'package:bird_discovery/widgets/custom_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BirdAnalyticsScreen extends StatefulWidget {
  const BirdAnalyticsScreen({super.key});
  @override
  State<BirdAnalyticsScreen> createState() => _BirdAnalyticsScreenState();
}

class _BirdAnalyticsScreenState extends State<BirdAnalyticsScreen>
    with TickerProviderStateMixin {
  final BirdAnalyticsController ctrl =
      Get.isRegistered<BirdAnalyticsController>()
          ? Get.find<BirdAnalyticsController>()
          : Get.put(BirdAnalyticsController());
  final RxInt _currentPage = 0.obs;
  final RxInt _selectedTab = 0.obs;
  TextEditingController suggestionsTextController = TextEditingController();
  TextEditingController errorTextController = TextEditingController();
  void _showMoreMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              top: 12.h,
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // drag indicator
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.darkGreyColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 36.h),

                // Menu items
                _menuTile(
                  asset: AppImages.heartIcon,
                  title: 'I Like this Content',
                  subtitle: null,
                  onTap: () => Navigator.pop(ctx),
                  arrow: false,
                ),
                SizedBox(height: 12.h),
                _menuTile(
                  asset: AppImages.errorIcon,
                  title: 'Error in Content',
                  subtitle: 'Incorrect content, poor, errors, etc.',
                  onTap: () {
                    Navigator.pop(ctx);
                    _showErrorSheet();
                  },
                  arrow: true,
                ),
                SizedBox(height: 12.h),
                _menuTile(
                  asset: AppImages.crossIcon,
                  title: 'Incorrect Identification',
                  subtitle: null,
                  onTap: () {
                    Navigator.pop(ctx);
                    // you could show another sheet here if desired
                  },
                  arrow: false,
                ),
                SizedBox(height: 12.h),
                _menuTile(
                  asset: AppImages.suggestionIcon1,
                  title: 'Suggestions',
                  subtitle: 'Help us make it more useful & better experience',
                  onTap: () {
                    Navigator.pop(ctx);
                    _showSuggestionsSheet();
                  },
                  arrow: true,
                ),
                SizedBox(height: 36.h),
              ],
            ),
          ),
    );
  }

  Widget _menuTile({
    required String asset,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool arrow = false,
  }) {
    return ListTile(
      leading: Image.asset(asset, width: 24.w, height: 24.h),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      subtitle:
          subtitle == null
              ? null
              : Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textGreyColor,
                ),
              ),
      trailing:
          arrow
              ? Icon(
                Icons.arrow_forward_ios,
                size: 16.w,
                color: AppColors.darkGreyColor,
              )
              : null,
      onTap: onTap,
    );
  }

  void _showSuggestionsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              top: 12.h,
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // drag indicator
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.darkGreyColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 12.h),

                // back row
                Row(
                  children: [
                    CupertinoNavigationBarBackButton(
                      color: AppColors.blackColor,
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    Spacer(),
                    Text(
                      'Suggestions',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                SizedBox(height: 16.h),

                // input box
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    minLines: 3,
                    maxLines: 6,
                    controller: suggestionsTextController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type here…',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // submit
                CustomElevatedButton(
                  isGradient: true,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  onclick: () async {
                    final result = await ctrl.sendSuggestions(
                      suggestionsTextController.text,
                    );
                    if (result) {
                      Get.snackbar('Successfull', 'Your suggestion is send');
                      Navigator.pop(ctx);
                    }
                    // Get.back();
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showErrorSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              top: 12.h,
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // drag indicator
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.darkGreyColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 12.h),

                // back row
                Row(
                  children: [
                    CupertinoNavigationBarBackButton(
                      color: AppColors.blackColor,
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    Spacer(),
                    Text(
                      'Error in Content',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                SizedBox(height: 16.h),

                // input box
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    controller: errorTextController,
                    minLines: 3,
                    maxLines: 6,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Please describe the errors…',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // submit
                CustomElevatedButton(
                  isGradient: true,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  onclick: () async {
                    final result = await ctrl.sendErrorInContent(
                      errorTextController.text,
                    );
                    if (result) {
                      Get.snackbar('Successfull', 'Your Error Message is send');
                      Navigator.pop(ctx);
                    }
                    // Get.back();
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Row(
                children: [
                  CustomIconButton(
                    onPressed: () => Get.back(),
                    child: Image.asset(AppImages.arrowLeft, height: 16.h),
                  ),
                  Spacer(),
                  CustomElevatedButton(
                    isGradient: false,
                    width: 147.w,
                    height: 48.h,
                    radius: 50.r,
                    bgColor: AppColors.secondaryColor,
                    onclick:
                        () => Get.to(
                          () => ShareMyFindScreen(),
                        ), // GetX navigation

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Share My Find',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Image.asset(
                          AppImages.shareIcon2,
                          height: 16.h,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CustomIconButton(
                    onPressed: _showMoreMenu,
                    child: Image.asset(AppImages.moreHorzIcon, height: 24.h),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Container(
                height: 264.h,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      itemCount: 3,
                      onPageChanged: (page) {
                        _currentPage.value = page;
                      },
                      itemBuilder: (context, index) {
                        final asset = ctrl.birdDetails.value!.images[index];

                        // final asset =
                        //     index == 0
                        //         ? AppImages.bird1
                        //         : index == 1
                        //         ? AppImages.bird2
                        //         : AppImages.bird3;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.r),
                            child: Image.asset(
                              asset,
                              width: double.infinity,
                              height: 264.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Row(
                              children: List.generate(
                                3,
                                (index) => AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                  height: 15.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    color:
                                        _currentPage.value == index
                                            ? AppColors.whiteColor
                                            : Colors.transparent,
                                    border: Border.all(
                                      color: AppColors.whiteColor,
                                      width: 0.5.w,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color:
                                          _currentPage.value == index
                                              ? AppColors.primaryColor
                                              : AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              BirdInfo(),
              SizedBox(height: 20.h),
              BirdDetailsSection(),
              SizedBox(height: 20.h),
              // ── Tab Buttons ───────────────────────────────
              Obx(
                () => Row(
                  children: [
                    // Overview
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectedTab.value = 0,
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color:
                                _selectedTab.value == 0
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  _selectedTab.value == 0
                                      ? Colors.white
                                      : AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Features
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectedTab.value = 1,
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color:
                                _selectedTab.value == 1
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Features',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  _selectedTab.value == 1
                                      ? Colors.white
                                      : AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // More
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectedTab.value = 2,
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color:
                                _selectedTab.value == 2
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'More',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  _selectedTab.value == 2
                                      ? Colors.white
                                      : AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // ── Tab Content ───────────────────────────────
              Obx(() {
                switch (_selectedTab.value) {
                  case 1:
                    return FeaturesTab();
                  case 2:
                    return MoreTab();
                  default:
                    return OverviewTab();
                }
              }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
