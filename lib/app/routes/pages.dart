import 'package:blackcoffer/app/modules/authentication/binding.dart';
import 'package:blackcoffer/app/modules/authentication/views/login.dart';
import 'package:blackcoffer/app/modules/home/binding.dart';
import 'package:blackcoffer/app/modules/home/views/videoPost.dart';
import 'package:blackcoffer/app/modules/splash/view.dart';
import 'package:blackcoffer/app/routes/routes.dart';
import 'package:get/get.dart';

import '../modules/base/binding.dart';
import '../modules/base/view.dart';
import '../modules/splash/binding.dart';

// manage all pages
class GetPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoute.login,
      page: () => AuthScreen(),
      binding: AuthScreenControllerBinding(),
    ),
    GetPage(
      name: AppRoute.base,
      page: () => AppBase(),
      binding: BaseBinding(),
    ),
    GetPage(
      name: AppRoute.home,
      page: () => VideoPostScreen(),
      binding: HomeScreenControllerBinding(),
    ),
  ];
}
