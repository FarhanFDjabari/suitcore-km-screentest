import 'package:get/get.dart';
import 'package:suitcore_screen_test/feature/first/first_controller.dart';

class FirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstController>(() => FirstController());
  }
}
