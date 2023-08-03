import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? displayName;
  String? phoneNumber;

  UserModel({
    this.uid,
    this.displayName,
    this.phoneNumber,
  });

  UserModel copyWith({
    String? uid,
    String? displayName,
    String? phoneNumber,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        displayName: displayName ?? this.displayName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        displayName: json["displayName"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
      };
}
