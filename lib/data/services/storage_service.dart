import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/constants/storage_keys.dart';
import '../models/user_model.dart';

class StorageService extends GetxService {
  late final GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // Generic methods
  T? read<T>(String key) => _box.read<T>(key);

  Future<void> write(String key, dynamic value) => _box.write(key, value);

  Future<void> remove(String key) => _box.remove(key);

  Future<void> clearAll() => _box.erase();

  bool hasData(String key) => _box.hasData(key);

  // Auth specific methods
  bool get isLoggedIn => _box.read<bool>(StorageKeys.isLoggedIn) ?? false;

  Future<void> setLoggedIn(bool value) async {
    await _box.write(StorageKeys.isLoggedIn, value);
  }

  String? getToken() => _box.read<String>(StorageKeys.userToken);

  Future<void> setToken(String token) async {
    await _box.write(StorageKeys.userToken, token);
  }

  Future<void> removeToken() async {
    await _box.remove(StorageKeys.userToken);
  }

  // User data methods
  UserModel? getUser() {
    final userData = _box.read<String>(StorageKeys.userData);
    if (userData != null) {
      return UserModel.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<void> setUser(UserModel user) async {
    await _box.write(StorageKeys.userData, jsonEncode(user.toJson()));
  }

  Future<void> removeUser() async {
    await _box.remove(StorageKeys.userData);
  }

  String? getUserEmail() => _box.read<String>(StorageKeys.userEmail);

  Future<void> setUserEmail(String email) async {
    await _box.write(StorageKeys.userEmail, email);
  }

  // Session management
  Future<void> clearSession() async {
    await removeToken();
    await removeUser();
    await setLoggedIn(false);
  }
}

