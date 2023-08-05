import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? phoneNumber;

  UserModel({
    this.uid,
    this.phoneNumber,
  });

  UserModel copyWith({
    String? uid,
    String? phoneNumber,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "phoneNumber": phoneNumber,
      };
}
