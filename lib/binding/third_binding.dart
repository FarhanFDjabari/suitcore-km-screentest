import 'package:get/get.dart';
import 'package:suitcore_screen_test/feature/third/third_controller.dart';

class ThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThirdController>(() => ThirdController());
  }
}
