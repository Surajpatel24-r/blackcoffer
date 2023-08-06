// // ignore_for_file: must_be_immutable

// import 'package:blackcoffer/app/data/models/videoModel.dart';
// import 'package:blackcoffer/app/modules/home/controller.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// class StaffVideoShowWidget extends StatelessWidget {
//   StaffVideoShowWidget({super.key});

//   var videoController = Get.find<HomeScreenController>();
//   VideoModel? videos;

//   @override
//   Widget build(BuildContext context) {
//     final VideoPlayerController videoPlayerController =
//         VideoPlayerController.network("${videos!.videoUrl}");

//     final ChewieController chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoPlay: true,
//       looping: true,
//     );

//     Future<bool> _onWillPop() async {
//       print("this is back button");
//       videoPlayerController.pause();
//       videoController.onInit();

//       return true;
//     }

//     return GetBuilder<HomeScreenController>(
//       builder: (s) {
//         return WillPopScope(
//           onWillPop: _onWillPop,
//           child: Column(
//             children: [
//               Chewie(
//                 controller: chewieController,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
