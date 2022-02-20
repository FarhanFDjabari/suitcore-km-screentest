import 'package:get/get.dart';
import 'package:suitcore_screen_test/data/remote/base/base_object_controller.dart';
import 'package:suitcore_screen_test/model/user.dart';
import 'package:suitcore_screen_test/routes/page_names.dart';

class SecondController extends BaseObjectController<User> {
  late User userData;
  late User currentUser;

  @override
  void onInit() {
    userData = User.fromJson(Get.arguments);
    currentUser = userData;
    super.onInit();
  }

  void changeSelectedUser(User user) {
    loadingState();
    userData = user;
    finishLoadData();
    update();
  }

  void goToChooseUser() {
    Get.toNamed(PageName.THIRD)?.then((value) {
      if (value != null) {
        userData = User.fromJson(value);
        update();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
