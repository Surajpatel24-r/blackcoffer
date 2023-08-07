// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:async';
import 'dart:io';

import 'package:blackcoffer/app/data/providers/storage_provider.dart';
import 'package:blackcoffer/app/modules/authentication/views/otp.dart';
import 'package:blackcoffer/app/modules/base/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../../core/values/keys.dart';
import '../models/userModel.dart';
import '../models/videoModel.dart';

class FirebaseProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageProvider _storageProvider = StorageProvider();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Phone Number Authentication
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
        UserModel userModel = UserModel(
          uid: user.uid,
          phoneNumber: user.phoneNumber ?? '', // Add other user details here
          // Add other user details here
        );

        // Save the user data to Firestore
        await uploadUserData(userModel);
        await _storageProvider.writeUserModel(userModel);
        Get.off(() => AppBase());
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

  // user data show
  Future<void> uploadUserData(UserModel userModel) async {
    try {
      final CollectionReference usersCollection =
          _firestore.collection('users');
      await usersCollection.doc(userModel.uid).set(userModel.toJson());
    } catch (e) {
      print('Error saving user data to Firestore: $e');
      throw e;
    }
  }

  // video upload to firebase
  Future<bool> createVideo(VideoModel updatedUser) async {
    var check = true;
    // UserModel user = await _storageProvider.readUserModel();
    try {
      CollectionReference videosCollection =
          _firestore.collection(KeysConstant.videos);
      // for unique videos collection setup
      final alldocs = await videosCollection.get();
      print(alldocs.docs.length);
      var len = 0;
      if (alldocs.docs.length != 0) {
        final last = alldocs.docs.last;
        len = int.parse((last.data() as Map<String, dynamic>)['docId']) + 1;
        print(len);
      }
      DocumentReference doc = videosCollection.doc(len.toString());
      // updatedUser.copyWith(docId: len.toString());
      await doc
          .set(updatedUser.copyWith(docId: len.toString()).toJson())
          .timeout(Duration(seconds: 5), onTimeout: () {
        check = false;
      });
      return check;
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", e.toString());
      return false;
    }
  }

  // Video upload to firebase
  Future<String> uploadVideoToFirebase(uid, File videoFile) async {
    try {
      final ref = await _firebaseStorage
          .ref()
          .child('RecordedVideos/$uid/${videoFile.path.split('/').last}')
          .putFile(videoFile);
      final url = await ref.ref.getDownloadURL();
      return url;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return 'null';
    }
  }

  // Video thumbnail upload to firebase
  Future<String> uploadVideoThumbnailToFirebase(
      uid, File videoFileThumbnail) async {
    try {
      final ref = await _firebaseStorage
          .ref()
          .child(
              'RecordedVideosThumbnail/$uid/${videoFileThumbnail.path.split('/').last}')
          .putFile(videoFileThumbnail);
      final url = await ref.ref.getDownloadURL();
      return url;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return 'null';
    }
  }

  // Get all the video and datas using Stream
  // Stream<List<VideoModel>> getVideoStream() {
  //   final CollectionReference videosCollection =
  //       FirebaseFirestore.instance.collection('video');
  //   return videosCollection.snapshots().map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => VideoModel.fromJson(doc.data() as Map<String, dynamic>))
  //         .toList()
  //         .reversed
  //         .toList();
  //   });
  // }

  // Get all the video and datas using Get Method
  Future<List<VideoModel>> getAllVideos() async {
    final CollectionReference videosCollection =
        FirebaseFirestore.instance.collection('video');
    try {
      final alldocs = await videosCollection.get();
      List<VideoModel> list = [];
      alldocs.docs.forEach((element) {
        list.add(VideoModel.fromJson(element.data() as Map<String, dynamic>));
      });
      return list;
    } catch (e) {
      return [];
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
