// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:async';

import 'package:blackcoffer/app/data/providers/storage_provider.dart';
import 'package:blackcoffer/app/modules/authentication/views/otp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import '../models/userModel.dart';

class FirebaseProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageProvider _storageProvider = StorageProvider();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      // existing code
      // await _firebaseAuth.verifyPhoneNumber(
      //   phoneNumber: phoneNumber,
      //   verificationCompleted: (PhoneAuthCredential credential) async {
      //     await _firebaseAuth.signInWithCredential(credential);
      //     Get.offAll(() => HomeScreen());
      //   },
      //   verificationFailed: (FirebaseAuthException e) {
      //     // Handle verification failure
      //     Get.snackbar("Error", "Verification failed: ${e.message}");
      //   },
      //   codeSent: (String verificationId, int? resendToken) {
      //     // Navigate to OTP screen and pass verificationId to OTP screen
      //     Get.to(() => OtpScreen(
      //           verificationId: '$verificationId',
      //         ));
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {},
      //   timeout: const Duration(seconds: 60),
      // );
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
          // authentication successful, do something
        },
        verificationFailed: (FirebaseAuthException e) {
          // authentication failed, do something
          Get.snackbar("Error", "Verification failed: ${e.message}");
          print("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) async {
          // code sent to phone number, save verificationId for later use
          String smsCode = ''; // get sms code from user
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          Get.to(OtpScreen(), arguments: [verificationId]);
          await _firebaseAuth.signInWithCredential(credential);
          // authentication successful, do something
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar("An error occurred while verifying the phone number.", "");
    }
  }

  // Future<void> signInWithOTP(String verificationId, String smsCode) async {
  //   try {
  //     final PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId,
  //       smsCode: smsCode,
  //     );
  //     await _firebaseAuth.signInWithCredential(credential);
  //     Get.offAll(() => HomeScreen());
  //   } catch (e) {
  //     Get.snackbar("Error", "Invalid OTP");
  //   }
  // }

  // Future<void> signInWithPhoneNumber(String phoneNumber) async {
  //   await _firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _firebaseAuth.signInWithCredential(credential);
  //       // authentication successful, do something
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       // authentication failed, do something
  //       Get.snackbar("Error", "Verification failed: ${e.message}");
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       // code sent to phone number, save verificationId for later use
  //       String smsCode = ''; // get sms code from user
  //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId,
  //         smsCode: smsCode,
  //       );
  //       Get.to(OtpScreen(), arguments: [verificationId]);
  //       await _firebaseAuth.signInWithCredential(credential);
  //       // authentication successful, do something
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

  // signOut the Account
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _storageProvider.writeUserModel(UserModel());
      print('User signed out successfully');
      return true;
    } catch (e) {
      print('Error signing out: $e');
      return false;
    }
  }
}
