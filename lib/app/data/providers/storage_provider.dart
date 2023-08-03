import 'dart:convert';

import '../../core/values/keys.dart';
import '../models/userModel.dart';
import '../services/storage/services.dart';

class StorageProvider {
  final StorageService _storageService = StorageService();

  Future<void> writeUserModel(UserModel user) async {
    _storageService.write(KeysConstant.user, jsonEncode(user));
  }

  Future<UserModel> readUserModel() async {
    var data = _storageService.read(KeysConstant.user) ?? "";
    if (data == "") {
      return UserModel();
    } else {
      UserModel user = UserModel.fromJson(jsonDecode(data));
      return user;
    }
  }
}
