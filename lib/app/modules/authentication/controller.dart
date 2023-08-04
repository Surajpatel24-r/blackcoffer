// ignore_for_file: unnecessary_null_comparison, unused_field

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/providers/firebase_provider.dart';

class AuthScreenController extends GetxController {
  final FirebaseProvider _firebaseProvider = FirebaseProvider();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final loginFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  //mobile auth
  final numberEditingController = TextEditingController();
  final otpEditingController = TextEditingController();

  // Setter Getter
  var isLoading = false.obs;
  void setLoading(bool value) {
    isLoading.value = value;
  }

  Rx<Country> selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  ).obs;

  void onSelectCountry(Country country) {
    selectedCountry.value = country;
  }

  void phoneNumberAuthentication() async {
    String mobile = numberEditingController.text;
    if (mobile == "") {
      Get.snackbar(
        "Please enter the mobile number!",
        "Failed",
      );
    } else {
      _firebaseProvider
          .verifyPhoneNumber("+${selectedCountry.value.phoneCode}$mobile");
    }
  }

  void otpVerificationAndLogin() {
    String? otpCode = otpEditingController.text;
    final String verificationId = Get.arguments[0];
    if (otpCode != null) {
      _firebaseProvider.verifyOtp(verificationId, otpCode);
    } else {
      Get.snackbar(
        "Enter 6-Digit code",
        "Failed",
      );
    }
  }

  @override
  void dispose() {
    numberEditingController.dispose();
    otpEditingController.dispose();
    super.dispose();
  }
}
