import 'package:bird_discovery/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Widget? child;
  final double? height;
  final double? width;
  final double? padding;
  const CustomIconButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.child,
    this.height,
    this.width,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed ?? () {},
      child: Container(
        height: height ?? 48.h,
        width: width ?? 48.w,
        padding: EdgeInsets.all(padding ?? 10.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.lightGreyColor,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
