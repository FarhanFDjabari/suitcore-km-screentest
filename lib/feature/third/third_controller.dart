import 'package:suitcore_screen_test/data/local/hive/hive_constants.dart';
import 'package:suitcore_screen_test/data/remote/api_services.dart';
import 'package:suitcore_screen_test/data/remote/base/base_list_controller.dart';
import 'package:suitcore_screen_test/model/user.dart';
import 'package:get/get.dart';

class ThirdController extends BaseListController<User> {
  @override
  void onInit() {
    getCacheBox(HiveConstants.USERS_BOX).then((value) => getUsers());
    super.onInit();
  }

  @override
  void loadNextPage() {
    getUsers(page: page + 1);
  }

  @override
  void refreshPage() {
    getUsers();
  }

  selectUser(User user) {
    Get.back(result: user.toJson());
  }

  Future<void> getUsers({int page = 1}) async {
    loadingState();
    await client.then((value) => value.getUsers(page).then((value) {
          hasNext = value.data!.isNotEmpty;
          this.page = page;
          if (page == 1) {
            dataList.clear();
            saveCacheAndFinish(
              value.data,
              idList: value.data?.map(
                ((e) => e.id.toString()),
              ),
            );
          } else {
            finishLoadData(list: value.data != null ? value.data! : []);
          }
        }));
  }
}
