// ignore_for_file: deprecated_member_use

import 'package:blackcoffer/app/data/models/videoModel.dart';
import 'package:blackcoffer/app/modules/home/controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../core/values/colors.dart';

class VideoPlayScreen extends StatelessWidget {
  final VideoModel? videoPlay;
  VideoPlayScreen({super.key, this.videoPlay});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(HomeScreenController());
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.network("${videoPlay!.videoUrl}");

    final ChewieController chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      // looping: true,
    );

    Future<bool> _onWillPop() async {
      print("this is back button");
      videoPlayerController.pause();
      return true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 237, 237, 237),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 18.r,
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 237, 237, 237),
              ),
              child: Icon(
                Icons.notifications_outlined,
                size: 19.r,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 220.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Center(
                        child: SizedBox(
                      height: 215.h,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: _controller.videoCompressLoading.value == false
                            ? WillPopScope(
                                onWillPop: _onWillPop,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Chewie(
                                    controller: chewieController,
                                  ),
                                  // child: Image.network(
                                  //   widget.videoPlay!.videoUrl!,
                                  //   filterQuality: FilterQuality.medium,
                                  //   width: double.maxFinite,
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: ColorConstant.indigo),
                              ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 18.r,
                    color: ColorConstant.pink,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 5.w, bottom: 7.0.h),
                  child: Text(
                    "${videoPlay!.city}, ${videoPlay!.state} ${videoPlay!.zipCode}",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ColorConstant.pink),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Text(
                    "Video Title:",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ColorConstant.indigo),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, right: 30.w, bottom: 7.0.h),
                  child: Text(
                    "${videoPlay!.videoTitle}",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ColorConstant.indigo),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Text(
                    "Video Category:",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ColorConstant.indigo),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, right: 30.w, bottom: 7.0.h),
                  child: Text(
                    "${videoPlay!.videoCategory}",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ColorConstant.indigo),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Container(
                    child: Text(
                      "Current City:",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorConstant.indigo),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, right: 30.w, bottom: 7.0.h),
                  child: Container(
                    child: Text(
                      "${videoPlay!.city}",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorConstant.indigo),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Container(
                    child: Text(
                      "Current State",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorConstant.indigo),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, right: 30.w, bottom: 7.0.h),
                  child: Container(
                    child: Text(
                      "${videoPlay!.state}",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorConstant.indigo),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Container(
                    child: Text(
                      "Description:",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorConstant.indigo),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                  child: Container(
                    child: Text(
                      "${videoPlay!.videoDescription}",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorConstant.indigo),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
