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
        "Location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
      };
}
