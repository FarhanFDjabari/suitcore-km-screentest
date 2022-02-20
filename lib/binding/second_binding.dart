import 'package:get/get.dart';
import 'package:suitcore_screen_test/feature/second/second_controller.dart';

class SecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondController>(() => SecondController());
  }
}
