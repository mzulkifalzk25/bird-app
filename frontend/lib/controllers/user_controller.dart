import 'dart:convert';

import 'package:bird_discovery/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final user = Rxn<UserModel>();
  final RxInt date = 0.obs;

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  // when user logs in saves user data
  Future<void> setUser(UserModel userData) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    user.value = userData;
    // date = date;
    await prefs.setString('user', jsonEncode(userData.toJson()));
    await prefs.setInt('date', date.value);
    await loadUserData();
  }

  // update user data in case of edit info
  Future<void> updateUserData(UserModel userData) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    user.value = userData;
    await prefs.setString('user', jsonEncode(userData.toJson()));
    await loadUserData();
  }

  // load user data when app reopens
  Future<void> loadUserData() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final savedDate = prefs.getInt('date');
    if (savedDate != null &&
        savedDate <= (DateTime.now().millisecondsSinceEpoch / 1000).round()) {
      await prefs.remove('user');
      await prefs.remove('date');
    } else {
      final savedUser = prefs.getString('user');
      if (savedUser != null) {
        user.value = UserModel.fromJson(jsonDecode(savedUser));
      }
    }
  }

  // remove user data from local storage on logout
  Future<void> clearUser() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    user.value = null;
    date.value = 0;
    await prefs.remove('user');
    await prefs.remove('date');

    print(user.value);
  }
}
