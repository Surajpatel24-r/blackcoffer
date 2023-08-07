import 'package:blackcoffer/app/modules/home/controller.dart';
import 'package:blackcoffer/app/modules/home/views/videoPlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../data/models/videoModel.dart';

class VideoViewListScreen extends StatefulWidget {
  VideoViewListScreen({super.key});

  @override
  State<VideoViewListScreen> createState() => _VideoViewListScreenState();
}

final _controller = Get.put(HomeScreenController());

class _VideoViewListScreenState extends State<VideoViewListScreen> {
  @override
  Widget build(BuildContext context) {
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
                logoutdialog(context, _controller);
              },
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 237, 237, 237),
                ),
                child: Icon(
                  Icons.logout_outlined,
                  size: 19.r,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller.searchController,
                onChanged: (value) {
                  // _controller.searchVideos(value);
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  focusColor: Colors.black,
                  contentPadding: EdgeInsets.only(right: 40.w, left: 12.w),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  labelText: "Search Videos...",
                  counterStyle: Theme.of(context).textTheme.bodyLarge,
                  helperStyle: Theme.of(context).textTheme.bodyLarge,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune_outlined),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            StreamBuilder<List<VideoModel>>(
              // stream:
              //     FirebaseFirestore.instance.collection('video').snapshots(),
              stream: _controller.getVideoStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // final videos = snapshot.data?.docs.reversed.map((doc) {
                  //   return VideoModel.fromJson(
                  //       doc.data() as Map<String, dynamic>);
                  // }).toList();
                  final videos = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: videos!.length,
                      itemBuilder: (context, index) {
                        VideoModel video = videos[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => VideoPlayScreen(
                                videoPlay: videos[index],
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                height: 90.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Card(
                                        elevation: 0,
                                        child: Container(
                                          height: 80.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              video.videoThumbnail!,
                                              filterQuality:
                                                  FilterQuality.medium,
                                              width: double.maxFinite,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.w),
                                      child: Container(
                                        width: 212.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: Text(
                                                "${video.videoTitle}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        fontSize: 15.5.sp),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 3.w,
                                                                top: 5.h),
                                                        child: Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          size: 13.r,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5.h),
                                                        child: Text(
                                                          "${video.city}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelSmall,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text("|"),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5.h),
                                                    child: Text(
                                                      "${video.videoCategory}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                            color: ColorConstant
                                                                .indigo,
                                                          ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.h),
                                              child: Container(
                                                width: 210.w,
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  '${video.videoDescription}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: ColorConstant
                                                              .indigo,
                                                          fontSize: 14.sp),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  logoutdialog(context, _controller) async {
    await Get.dialog(
      AlertDialog(
        title: Text('Confirm Logout',
            style: Theme.of(context).textTheme.bodyLarge),
        content: Text('Are you sure you want to logout?',
            style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: ColorConstant.indigo),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => ColorConstant.pink)),
            child: Text(
              'Logout',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: ColorConstant.indigo),
            ),
            onPressed: () {
              // Perform logout logic here
              _controller.logOut();
            },
          ),
        ],
      ),
    );
  }
}
