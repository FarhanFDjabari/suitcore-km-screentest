import 'package:get/get.dart';
import 'package:suitcore_screen_test/feature/auth/auth_controller.dart';
import 'package:suitcore_screen_test/model/user.dart';

class OtherController extends GetxController {
  final AuthController authController = AuthController.find;

  User? get user => authController.user;

  Future<void> signOut() async {
    await authController.signOut();
  }
}
