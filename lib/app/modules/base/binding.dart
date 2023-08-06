import 'package:blackcoffer/app/modules/base/controller.dart';
import 'package:get/get.dart';

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController());
    // Get.put(HomeScreenController());
    // Get.put(SplashController());
  }
}
