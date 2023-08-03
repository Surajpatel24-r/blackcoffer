// ignore_for_file: body_might_complete_normally_nullable

import 'package:blackcoffer/app/core/values/colors.dart';
import 'package:blackcoffer/app/core/values/images.dart';
import 'package:blackcoffer/app/modules/authentication/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  final String? verificationId;
  OtpScreen({super.key, this.verificationId});

  final _controller = Get.put(AuthScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          // key: _controller.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 38.0.h),
                    child: Container(
                      height: 170.h,
                      width: 170.w,
                      child: Image(
                        image: AssetImage(ImagesConstant.logo),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 26.0.h, left: 37.w, bottom: 7.0.h),
                child: Text(
                  "OTP",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _controller.otpEditingController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  validator: (value) {},
                  maxLength: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    hintText: "Enter OTP",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: ColorConstant.indigo),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: ColorConstant.indigo),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Did not get otp, ",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    InkWell(
                      onTap: () {
                        // _controller.setLoginState(true);
                      },
                      child: Text(
                        "resend?",
                        style: TextStyle(color: ColorConstant.pink),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                    child: SizedBox(
                      height: 42.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: ColorConstant.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  // Get.to(OtpScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Icon(Icons.arrow_back_ios_new_rounded,
                          size: 15.r, color: ColorConstant.pink),
                    ),
                    Text(
                      "Back",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: ColorConstant.pink),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
