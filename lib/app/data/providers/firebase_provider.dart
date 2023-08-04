// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:async';
import 'dart:io';

import 'package:blackcoffer/app/data/providers/storage_provider.dart';
import 'package:blackcoffer/app/modules/authentication/views/otp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../modules/home/views/view.dart';
import '../models/userModel.dart';

class FirebaseProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageProvider _storageProvider = StorageProvider();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", "Verification failed: ${e.message}");
          print("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = ''; // get sms code from user
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          Get.to(OtpScreen(), arguments: [verificationId]);
          await _firebaseAuth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar("An error occurred while verifying the phone number.", "");
    }
  }

// verify otp
  Future<void> verifyOtp(String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        Get.to(HomeScreen());
      } else {
        Get.snackbar(
          "Authentication failed",
          "Failed",
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        e.message.toString(),
        "Failed",
      );
    }
  }

  Future<String?> uploadImageToFirebase(uid, XFile videoFile) async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child('Recorded_videos').child(uid);

      // final existingVideoExists =
      //     await ref.getDownloadURL().then((_) => true).catchError((_) => false);

      // print(existingVideoExists);
      final uploadVideo = ref.putFile(File(videoFile.path));

      final taskSnapshot = await uploadVideo.whenComplete(() => null);
      final videoUrl = await taskSnapshot.ref.getDownloadURL();

      return videoUrl;
    } catch (e) {
      print('Error uploading/updating image: $e');
      return null;
    }
  }

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
