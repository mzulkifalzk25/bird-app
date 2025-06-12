import 'dart:async';

import 'package:bird_discovery/controllers/user_controller.dart';
import 'package:bird_discovery/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final UserController userController =
      Get.isRegistered<UserController>()
          ? Get.find<UserController>()
          : Get.put(UserController());

  RxBool isPasswordObsecure = true.obs;
  RxBool isConfirmPasswordObsecure = false.obs;
  RxBool isRememberMe = false.obs;

  RxBool isLoading = false.obs;

  Future<bool> signUpUser(String email, String name, String password) async {
    isLoading.value = true;
    // print('email: $email  name: $name  password: $password');

    await Future.delayed(Duration(seconds: 3));

    isLoading.value = false;
    return true;
  }

  Future<bool> loginUser(String email, String password) async {
    isLoading.value = true;

    // print('email: $email  password: $password');
    final json = {
      'user': {
        'name': 'test',
        'email': email,
        'password': password,
        // 'dateOfBirth': '222222',
        // 'location': 'abx',
      },
    };
    final user = UserModel.fromJson(json['user']!);
    if (isRememberMe.value) {
      userController.date.value =
          ((DateTime.now().add(Duration(days: 30)).millisecondsSinceEpoch) /
                  1000)
              .round();
      print('remember me time');
      print(userController.date.value);
      print('current time');
      print((DateTime.now().millisecondsSinceEpoch / 1000).round());
      userController.setUser(user);
    }
    print('''
      user name : ${user.name}
      user email: ${user.email}
      user password: ${user.password}''');

    await Future.delayed(Duration(seconds: 3));

    isLoading.value = false;
    return true;
  }

  Future<bool> sendOTP(String email) async {
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(email)) {
      Get.snackbar(
        'Error',
        "Invalid email format",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }
    print(email);
    isLoading.value = true;
    // TODO backend implementation here
    Timer(Duration(seconds: 6), () {});
    isLoading.value = false;
    return true;
  }

  Future<bool> verifyOTP(String email, String otp) async {
    isLoading.value = true;
    // TODO backend logic goes here
    Timer(Duration(seconds: 6), () {
      isLoading.value = false;
    });
    return true;
  }

  Future<bool> resetPassword(String email, String password) async {
    isLoading.value = true;
    Timer(Duration(seconds: 6), () {
      isLoading.value = false;
    });

    return true;
  }

  bool validateSignup(
    String name,
    String email,
    String password,
    // String confirmPassword,
  ) {
    if (name.isEmpty) {
      Get.snackbar(
        "Error",
        "Name cannot be empty",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(name)) {
      Get.snackbar(
        "Error",
        "Invalid Name",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(email)) {
      Get.snackbar(
        'Error',
        "Invalid email format",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar(
        'Error',
        "Password is required",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        "Password must be at least 6 characters long.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    // if (password != confirmPassword) {
    //   Get.snackbar(
    //     'Error',
    //     "Confirm Password should match",
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.transparent,
    //     colorText: Colors.black,
    //   );
    //   return false;
    // }

    return true;
  }

  bool validateSignin(String email, String password) {
    print('inside of auth controller');
    print(email);
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(email)) {
      Get.snackbar(
        'Error',
        "Invalid email format",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar(
        'Error',
        "Password is required",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    return true;
  }

  bool validateResetPassword(String password, String confirmPassword) {
    if (password.isEmpty) {
      Get.snackbar(
        'Error',
        "Password is required",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        "Password must be at least 6 characters long.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        "Confirm Password should match",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
      return false;
    }

    return true;
  }

  void togglePasswordVisibility() {
    isPasswordObsecure.value = !isPasswordObsecure.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObsecure.value = !isConfirmPasswordObsecure.value;
  }

  void toggleCheckboxRemeber() {
    isRememberMe.value = !isRememberMe.value;
  }
}
