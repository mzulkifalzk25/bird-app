import 'package:bird_discovery/views/identifyBird/controllers/identify_bird_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/views/identifyBird/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BirdSizeScreen extends StatefulWidget {
  const BirdSizeScreen({super.key});

  @override
  State<BirdSizeScreen> createState() => _BirdSizeScreenState();
}

class _BirdSizeScreenState extends State<BirdSizeScreen> {
  final IdentifyBirdController identifyBirdController =
      Get.isRegistered<IdentifyBirdController>()
          ? Get.find<IdentifyBirdController>()
          : Get.put(IdentifyBirdController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ListView.builder(
        itemCount: identifyBirdController.birdSizeList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: ListTileWidget(
              ontap: () {
                identifyBirdController.birdSize.value =
                    identifyBirdController.birdSizeList[index]['measurement']!;
              },
              hasTrailing: SizedBox(
                height: 10.h,
                width: 10.w,
                child: Obx(
                  () => Checkbox(
                    value:
                        identifyBirdController.birdSize.value ==
                        identifyBirdController
                            .birdSizeList[index]['measurement'],
                    onChanged: (value) {},
                  ),
                ),
              ),
              leading: SizedBox(
                height: 30.h,
                width: 30.w,
                child: Image.asset(
                  identifyBirdController.birdSizeList[index]['image']!,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    identifyBirdController.birdSizeList[index]['size']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "(${identifyBirdController.birdSizeList[index]['measurement']!})",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
