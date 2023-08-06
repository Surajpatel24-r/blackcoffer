// ignore_for_file: body_might_complete_normally_nullable

import 'package:blackcoffer/app/core/values/colors.dart';
import 'package:blackcoffer/app/core/values/images.dart';
import 'package:blackcoffer/app/modules/authentication/controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

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
                  "Mobile Number",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _controller.numberEditingController,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  validator: (value) {},
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    hintText: "Enter Phone number",
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
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 550,
                              ),
                              onSelect: (value) {
                                _controller.onSelectCountry(value);
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            return Text(
                              "${_controller.selectedCountry.value.flagEmoji} + ${_controller.selectedCountry.value.phoneCode}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: ColorConstant.black,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
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
                        onPressed: () {
                          _controller.phoneNumberAuthentication();
                        },
                        child: Center(
                            child: _controller.setLoading != true
                                ? Text(
                                    "Next",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: ColorConstant.white),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: ColorConstant.pink,
                                    ),
                                  )),
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
            ],
          ),
        ),
      ),
    );
  }
}
