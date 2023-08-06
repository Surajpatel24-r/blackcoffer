import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/values/colors.dart';
import 'controller.dart';

// ignore: must_be_immutable
class AppBase extends StatelessWidget {
  AppBase({super.key});

  var baseController = Get.put(BaseController());
  DateTime? _currentBackPressTime;

  Future<bool> _onWillPop() async {
    print("this is back button");
    // Handle the back button press here
    // You can perform custom actions or show a snackbar
    // If enough time hasn't passed since the last back button press, exit the app
    if (_currentBackPressTime == null ||
        DateTime.now().difference(_currentBackPressTime!) >
            Duration(seconds: 2)) {
      _currentBackPressTime = DateTime.now();
      Get.snackbar("Press back again to exit", "");
      return false; // Prevent back navigation for now
    } else {
      SystemNavigator.pop();
      return true; // Allow back navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: ColorConstant.indigo,
        body: Obx(() {
          return baseController.widgetOptions
              .elementAt(baseController.index.toInt());
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (value) {
              baseController.changeChipIndex(value);

              print("value-===================$value");
            },
            currentIndex: baseController.index.value,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            unselectedItemColor: ColorConstant.indigo,
            selectedItemColor: ColorConstant.pink,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 22.sp,
                  ),
                  label: 'HOME'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.video_collection_outlined,
                    size: 22.sp,
                  ),
                  label: 'VIDEO'),
            ],
          ),
        ),
      ),
    );
  }
}
