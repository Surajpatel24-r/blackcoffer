// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  String? docId;
  String? videoTitle;
  String? videoDescription;
  String? createdBy;
  String? videoCategory;
  String? videoUrl;
  String? videoThumbnail;
  String? city;
  String? state;
  String? zipCode;
  String? street;
  List<double>? location;

  VideoModel({
    this.docId,
    this.videoTitle,
    this.videoDescription,
    this.createdBy,
    this.videoCategory,
    this.videoUrl,
    this.videoThumbnail,
    this.city,
    this.state,
    this.zipCode,
    this.street,
    this.location,
  });

  VideoModel copyWith({
    String? docId,
    String? videoTitle,
    String? videoDescription,
    String? createdBy,
    String? videoCategory,
    String? videoUrl,
    String? videoThumbnail,
    String? city,
    String? state,
    String? zipCode,
    String? street,
    List<double>? location,
  }) =>
      VideoModel(
        docId: docId ?? this.docId,
        videoTitle: videoTitle ?? this.videoTitle,
        videoDescription: videoDescription ?? this.videoDescription,
        createdBy: createdBy ?? this.createdBy,
        videoCategory: videoCategory ?? this.videoCategory,
        videoUrl: videoUrl ?? this.videoUrl,
        videoThumbnail: videoThumbnail ?? this.videoThumbnail,
        city: city ?? this.city,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        street: street ?? this.street,
        location: location ?? this.location,
      );

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        docId: json["docId"],
        videoTitle: json["videoTitle"],
        videoDescription: json["videoDescription"],
        createdBy: json["createdBy"],
        videoCategory: json["videoCategory"],
        videoUrl: json["videoUrl"],
        videoThumbnail: json["videoThumbnail"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        street: json["street"],
        location: json["Location"] == null
            ? []
            : List<double>.from(json["Location"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "docId": docId,
        "videoTitle": videoTitle,
        "videoDescription": videoDescription,
        "createdBy": createdBy,
        "videoCategory": videoCategory,
        "videoUrl": videoUrl,
        "videoThumbnail": videoThumbnail,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "street": street,
        "Location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
      };
}
