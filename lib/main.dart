// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/home/views/videoPlay.dart';
import 'app/modules/home/views/videoPost.dart';
import 'app/modules/home/views/videoView.dart';
import 'app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          // theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          title: 'BlackCoffer',
          initialRoute: '/',
          getPages: GetPages.pages,
          // home: VideoViewListScreen(),
        );
      },
    );
  }
}
