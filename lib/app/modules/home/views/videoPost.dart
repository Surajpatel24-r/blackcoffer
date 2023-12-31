import 'dart:io';

import 'package:blackcoffer/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../widgets/text_feild.dart';

class VideoPostScreen extends StatefulWidget {
  VideoPostScreen({super.key});

  @override
  State<VideoPostScreen> createState() => _VideoPostScreenState();
}

final _controller = Get.put(HomeScreenController());

class _VideoPostScreenState extends State<VideoPostScreen> {
  @override
  Widget build(BuildContext context) {
    _controller.onInit();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
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
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _controller.selectVideoFromCamera();
              },
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 237, 237, 237),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 19.r,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _controller.refreshData();
        },
        child: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 180.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        _controller.selectedVideoFile != null
                            ? Center(
                                child: SizedBox(
                                  height: 175.h,
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.file(
                                        File(_controller.uploadVideoThumbnail
                                            .toString()),
                                        filterQuality: FilterQuality.medium,
                                        width: double.maxFinite,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 175.h,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.selectVideoFromCamera();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          size: 40.r,
                                          color: ColorConstant.pink,
                                        ),
                                        Text(
                                          "Open Camera",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: ColorConstant.pink),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Text(
                    "Video Title",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: AppTextField(
                    label: "Enter Video title",
                    maxLines: 1,
                    controller: _controller.videoTitleController,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Text(
                    "Description",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    controller: _controller.videoDescriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      focusColor: Colors.black,
                      contentPadding:
                          EdgeInsets.only(right: 40.w, left: 12.w, top: 15.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      labelText: "Enter video description.....",
                      counterStyle: Theme.of(context).textTheme.bodyLarge,
                      helperStyle: Theme.of(context).textTheme.bodyLarge,
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 30.w, bottom: 7.0.h),
                  child: Text(
                    "Video Category",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: AppTextField(
                    label: "Enter category",
                    maxLines: 1,
                    controller: _controller.videoCategoryController,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Location",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      InkWell(
                        onTap: () {
                          _controller.fetchLocation();
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.pink,
                            ),
                            Text(
                              "Get Current Location",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.pink),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, bottom: 7.0.h),
                      child: Text(
                        "Street",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: AppTextField(
                        label: "Enter Street",
                        controller: _controller.streetController,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 30.0.h, bottom: 7.0.h),
                              child: Text(
                                "Current city",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            AppTextField(
                              label: "Enter your city",
                              controller: _controller.cityController,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0.h, bottom: 7.0.h, left: 12),
                              child: Text(
                                "Zip Code",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            AppTextField(
                              label: "Zip Code",
                              controller: _controller.zipCodeController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 30.0.h, left: 30.w, bottom: 7.0.h),
                      child: Text(
                        "Current State",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: AppTextField(
                        label: "Enter your city",
                        controller: _controller.stateController,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 28.w, vertical: 21.h),
                      child: SizedBox(
                        height: 42.h,
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.postAllVideosDatas();
                          },
                          child: Center(
                            child: Text("Add Video"),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
