import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/providers/firebase_provider.dart';

class AuthScreenController extends GetxController {
  final FirebaseProvider _firebaseProvider = FirebaseProvider();

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

  String? _verificationId;
  String? get verificationId => _verificationId;

  void setVerificationId(String? id) {
    _verificationId = id;
    update();
  }

  // void onSubmitPhoneNumber() {
  //   String phoneNumber = numberEditingController.text;
  //   _firebaseProvider.signInWithPhoneNumber(phoneNumber);
  // }

  void userLogin() async {
    String mobile = numberEditingController.text;
    if (mobile == "") {
      Get.snackbar(
        "Please enter the mobile number!",
        "Failed",
        colorText: Colors.white,
      );
    } else {
      _firebaseProvider
          .verifyPhoneNumber("+${selectedCountry.value.phoneCode}$mobile");
    }
  }

  @override
  void dispose() {
    numberEditingController.dispose();
    super.dispose();
  }

  // void onSubmitOTP() {
  //   _firebaseProvider.signInWithOTP(
  //       _verificationId.toString(), otpEditingController.text);
  // }
}
