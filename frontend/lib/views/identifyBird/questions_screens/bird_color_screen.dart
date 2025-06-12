import 'package:bird_discovery/views/identifyBird/controllers/identify_bird_controller.dart';
import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/views/identifyBird/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BirdColorScreen extends StatefulWidget {
  const BirdColorScreen({super.key});

  @override
  State<BirdColorScreen> createState() => _BirdColorScreenState();
}

class _BirdColorScreenState extends State<BirdColorScreen> {
  final IdentifyBirdController identifyBirdController =
      Get.isRegistered<IdentifyBirdController>()
          ? Get.find<IdentifyBirdController>()
          : Get.put(IdentifyBirdController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GridView.builder(
        itemCount: identifyBirdController.birdColorList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the number of columns as needed
          // crossAxisSpacing: 10.0,
          // mainAxisSpacing: 10.0,
          childAspectRatio: 2.1,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: ListTileWidget(
              ontap: () {
                identifyBirdController.birdColor.value =
                    identifyBirdController.birdColorList[index]['colorName'];
              },
              width: 163.w,
              height: 60.h,
              hasTrailing: SizedBox(
                height: 10.h,
                width: 10.w,
                child: Obx(
                  () => Checkbox(
                    value:
                        identifyBirdController.birdColor.value ==
                        identifyBirdController
                            .birdColorList[index]['colorName'],
                    onChanged: (value) {},
                  ),
                ),
              ),
              leading: SizedBox(
                width: 25.w,
                height: 25.h,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: identifyBirdController.birdColorList[index]['color'],
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    border: Border.all(
                      color:
                          identifyBirdController
                                      .birdColorList[index]['colorName'] ==
                                  'White'
                              ? AppColors.lightGrayColor
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
              child: Text(
                identifyBirdController.birdColorList[index]['colorName'],
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
