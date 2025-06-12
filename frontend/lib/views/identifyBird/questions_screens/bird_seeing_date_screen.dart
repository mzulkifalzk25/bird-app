import 'package:bird_discovery/utils/app_colors.dart';
import 'package:bird_discovery/views/identifyBird/controllers/identify_bird_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BirdSeeingDateScreen extends StatefulWidget {
  const BirdSeeingDateScreen({super.key});

  @override
  State<BirdSeeingDateScreen> createState() => _BirdSeeingDateScreenState();
}

class _BirdSeeingDateScreenState extends State<BirdSeeingDateScreen> {
  final IdentifyBirdController identifyBirdController =
      Get.isRegistered<IdentifyBirdController>()
          ? Get.find<IdentifyBirdController>()
          : Get.put(IdentifyBirdController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SizedBox(
        height: 248.h,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          showDayOfWeek: false,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (DateTime value) {
            identifyBirdController.birdDate.value = DateFormat(
              'dd-MMMM-yyyy',
            ).format(value);
            print(DateFormat('dd-MMMM-yyyy').format(value));
          },
        ),
      ),
    );
  }
}
