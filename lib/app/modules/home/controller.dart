import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class HomeScreenController extends GetxController {
  // late TextEditingController cityController;
  // late TextEditingController stateController;
  // late TextEditingController zipCodeController;
  // late TextEditingController streetController;

  final TextEditingController videoTitleController = TextEditingController();
  final TextEditingController videoDescriptionController =
      TextEditingController();
  final TextEditingController videoCategoryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  // @override
  // void onInit() async {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }

  // var isLoading = false.obs;
  // void setIsLoading(value) {
  //   isLoading.value = value;
  // }

  // var isLocationLoading = false.obs;
  // void setIsLocationLoading(value) {
  //   isLocationLoading.value = value;
  // }

  // void initTextEditingController() {
  //   cityController = TextEditingController();
  //   stateController = TextEditingController();
  //   zipCodeController = TextEditingController();
  //   streetController = TextEditingController();
  //   // cityController.text = user!.city ?? '';
  //   // stateController.text = user!.state ?? '';
  //   // zipCodeController.text = user!.zipCode ?? '';
  //   // streetController.text = user!.street ?? '';
  // }

  // void disposeTextEditingController() {
  //   cityController.dispose();
  //   stateController.dispose();
  //   zipCodeController.dispose();
  //   streetController.dispose();
  // }

  // Video Section
  Rx<File?> selectedVideo = Rx<File?>(null);
  File? selectedVideoFile;
  RxString videoName = ''.obs;
  RxString videoSize = ''.obs;
  RxString videoDate = ''.obs;
  RxString videoThumbnail = ''.obs;
  String? uploadVideoThumbnail;
  String? videoPathString = '';

  RxBool videoCompressLoading = false.obs;

  // Video Thumbnail
  Future<String> generateVideoThumbnail(File videoFile) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );
    return thumbnailPath ?? "";
  }

  // camera video record
  void selectVideoFromCamera() async {
    videoCompressLoading.value = true;
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.camera,
    );
    if (video != null) {
      selectedVideo.value = File(video.path);
      selectedVideoFile = File(video.path);

      // Reduce video name length by 57%
      final reducedLength = (videoName.value.length * 0.57).toInt();
      videoName.value = videoName.value.substring(0, reducedLength) + ".mp4";
      videoSize.value = '${formatVideoSize(selectedVideo.value!.lengthSync())}';
      videoDate.value = formatDate(selectedVideo.value!.lastModifiedSync());
      uploadVideoThumbnail = await generateVideoThumbnail(selectedVideo.value!);
      print("File Path: ${selectedVideo.value}");
      print("Video Name: ${videoName.value}");
      print("Video Size: ${videoSize.value}");
      print("Video Date: ${videoDate.value}");
      print("Video Thumbnail: $videoThumbnail");
      _compressVideo(video.path);
      videoCompressLoading.value = false;
    } else {
      print("selectedVideo--=-=-=-=-=-=-=_${selectedVideo}");
      // User canceled the file selection.
      print("Not Showing files");
      // EasyLoading.showError("File not find");
      videoCompressLoading.value = false;
    }
  }

  _compressVideo(String videoPath) async {
    try {
      videoCompressLoading.value = true;
      await VideoCompress.setLogLevel(0);
      final MediaInfo? info = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false,
        includeAudio: true,
      );
      final thumbnailFile = await VideoCompress.getFileThumbnail(
        videoPath,
        quality: 25, // default(100)
        position: -1, // default(-1)
      );

      videoPathString = info!.path!.toString();
      uploadVideoThumbnail = thumbnailFile.path;
      print("Video info ------${info.toJson()}");
      videoSize.value = formatVideoSize(info.filesize!.toInt());
      videoCompressLoading.value = false;
    } catch (e) {
      videoCompressLoading.value = false;
      print(e);
    }
  }

  // Video Size
  String formatVideoSize(int fileSize) {
    if (fileSize < 1024) {
      return '$fileSize bytes';
    } else if (fileSize < 1024 * 1024) {
      double sizeInKB = fileSize / 1024;
      return '${sizeInKB.toStringAsFixed(2)} KB';
    } else {
      double sizeInMB = fileSize / (1024 * 1024);
      return '${sizeInMB.toStringAsFixed(2)} MB';
    }
  }

  // Video Upload DateFormat
  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd-MMM-yyyy').format(date);
    }
    return '';
  }

  // void fetchLocation() async {
  //   setIsLocationLoading(true);
  //   final latLogList = await _getCurrentLocation();
  //   if (latLogList.isNotEmpty) {
  //     // List<Placemark> placemarks =
  //     //     await placemarkFromCoordinates(latLogList[0], latLogList[1]);
  //     // streetController.text = placemarks[2].street!;
  //     // cityController.text = placemarks[0].locality!;
  //     // zipCodeController.text = placemarks[0].postalCode!;
  //     // stateController.text = placemarks[0].administrativeArea!;
  //     setIsLocationLoading(false);
  //   } else {
  //     setIsLocationLoading(false);
  //   }
  // }

  // Future<List<double>> _getCurrentLocation() async {
  //   List<double> tempList = [];
  //   try {
  //     PermissionStatus permissionStatus = await Permission.location.request();
  //     if (permissionStatus.isGranted) {
  //       Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );
  //       tempList.assignAll([position.latitude, position.longitude]);
  //       return tempList;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     printInfo(info: e.toString());
  //     return [];
  //   }
  // }
}
