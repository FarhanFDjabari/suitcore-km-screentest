import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suitcore_screen_test/data/remote/base/base_object_controller.dart';
import 'package:suitcore_screen_test/data/remote/base/base_refresher_status.dart';
import 'package:suitcore_screen_test/feature/auth/auth_controller.dart';
import 'package:suitcore_screen_test/model/user.dart';

class FirstController extends BaseObjectController {
  final AuthController authController = AuthController.find;

  TextEditingController palindromeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    palindromeController.dispose();
    super.onClose();
  }

  void checkPalindrome() {
    status = RefresherStatus.loading;
    String valueReversed = palindromeController.text.split('').reversed.join();
    if (palindromeController.text.replaceAll(' ', '') ==
        valueReversed.replaceAll(' ', '')) {
      status = RefresherStatus.success;
      Get.snackbar('txt_is_palindrome'.tr, message.toString(),
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      status = RefresherStatus.success;
      Get.snackbar('txt_is_not_palindrome'.tr, message.toString(),
          backgroundColor: Colors.amber, colorText: Colors.white);
    }
  }

  void bypassLogin() async {
    status = RefresherStatus.loading;
    update();
    await Future.delayed(Duration(seconds: 2));
    var user = User(
      id: 1,
      firstName: nameController.text,
      email: 'email@test',
      lastName: "test",
      avatarUrl: 'https://reqres.in/img/faces/7-image.jpg',
    );
    authController.saveAuthData(user: user, token: "a");
    finishLoadData();
    authController.setAuth();
  }
}
