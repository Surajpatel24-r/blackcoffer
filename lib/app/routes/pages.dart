import 'package:blackcoffer/app/modules/authentication/binding.dart';
import 'package:blackcoffer/app/modules/authentication/views/login.dart';
import 'package:blackcoffer/app/modules/home/binding.dart';
import 'package:blackcoffer/app/modules/home/views/view.dart';
import 'package:blackcoffer/app/routes/routes.dart';
import 'package:get/get.dart';

// manage all pages
class GetPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => AuthScreen(),
      binding: AuthScreenControllerBinding(),
    ),
    GetPage(
      name: AppRoute.home,
      page: () => HomeScreen(),
      binding: HomeScreenControllerBinding(),
    ),
  ];
}
