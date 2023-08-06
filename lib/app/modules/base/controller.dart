import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/views/videoPost.dart';
import '../home/views/videoView.dart';

class BaseController extends GetxController {
  var index = 0.obs;

  void changeChipIndex(int value) {
    index.value = value;
  }

  List<Widget> widgetOptions = <Widget>[
    VideoPostScreen(),
    VideoViewListScreen(),
  ].obs;
}
