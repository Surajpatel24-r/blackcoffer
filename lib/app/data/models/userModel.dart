// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? displayName;
  String? phoneNumber;
  bool? phoneVerified;
  String? videoTitle;
  String? videoDescription;
  String? videoCategory;
  String? videoUrl;
  String? city;
  String? state;
  String? zipCode;
  String? street;
  List<double>? location;

  UserModel({
    this.uid,
    this.displayName,
    this.phoneNumber,
    this.phoneVerified,
    this.videoTitle,
    this.videoDescription,
    this.videoCategory,
    this.videoUrl,
    this.city,
    this.state,
    this.zipCode,
    this.street,
    this.location,
  });

  UserModel copyWith({
    String? uid,
    String? displayName,
    String? phoneNumber,
    bool? phoneVerified,
    String? videoTitle,
    String? videoDescription,
    String? videoCategory,
    String? videoUrl,
    String? city,
    String? state,
    String? zipCode,
    String? street,
    List<double>? location,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        displayName: displayName ?? this.displayName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        videoTitle: videoTitle ?? this.videoTitle,
        videoDescription: videoDescription ?? this.videoDescription,
        videoCategory: videoCategory ?? this.videoCategory,
        videoUrl: videoUrl ?? this.videoUrl,
        city: city ?? this.city,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        street: street ?? this.street,
        location: location ?? this.location,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        displayName: json["displayName"],
        phoneNumber: json["phoneNumber"],
        phoneVerified: json["phoneVerified"],
        videoTitle: json["videoTitle"],
        videoDescription: json["videoDescription"],
        videoCategory: json["videoCategory"],
        videoUrl: json["videoUrl"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        street: json["street"],
        location: json["Location"] == null
            ? []
            : List<double>.from(json["Location"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "phoneVerified": phoneVerified,
        "videoTitle": videoTitle,
        "videoDescription": videoDescription,
        "videoCategory": videoCategory,
        "videoUrl": videoUrl,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "street": street,
        "Location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
      };
}
