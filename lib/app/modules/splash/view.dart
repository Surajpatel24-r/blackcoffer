import 'package:blackcoffer/app/core/values/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/values/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.white,
        body: Center(
          child: Container(
            height: 170.h,
            width: 170.w,
            child: Image(image: AssetImage(ImagesConstant.logo)),
          ),
        ));
  }
}
