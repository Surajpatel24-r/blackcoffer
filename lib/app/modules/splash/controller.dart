import 'dart:async';

import 'package:blackcoffer/app/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  late Timer _timer;
  // final StorageProvider _storageProvider = StorageProvider();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _splashTime();
  }

  void _splashTime() async {
    // UserModel user = await _storageProvider.readUserModel();
    // print("userType --=--=-${user.phoneNumber}");

    _timer = Timer(const Duration(seconds: 3), () async {
      // print("${user.uid}  ${user.phoneNumber}");
      // if (user.uid != null) {
      //   Get.offAllNamed(AppRoute.base);
      //   Get.delete<SplashController>();
      // } else {
      //   Get.offAllNamed(AppRoute.login);
      //   Get.delete<SplashController>();
      // }

      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        // User is already signed in, redirect to the AppBase() screen
        Get.offAllNamed(AppRoute.base);
        Get.delete<SplashController>();
      } else {
        // User is not signed in, redirect to the login screen
        Get.offAllNamed(AppRoute.login);
        Get.delete<SplashController>();
      }
      Get.delete<SplashController>();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
