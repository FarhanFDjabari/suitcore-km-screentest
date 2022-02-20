import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suitcore_screen_test/feature/third/third_controller.dart';
import 'package:suitcore_screen_test/feature/third/widgets/user_list.dart';
import 'package:suitcore_screen_test/utills/widget/state_handle_widget.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: GetBuilder<ThirdController>(
            builder: (controller) {
              return StateHandleWidget(
                loadingEnabled: controller.isShimmering,
                emptyEnabled: controller.isEmptyData,
                emptySubtitle: 'txt_empty_user'.tr,
                errorEnabled: controller.isError,
                errorTitle: 'txt_error_general'.tr,
                onRetryPressed: () {
                  controller.refreshPage();
                },
                body: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    centerTitle: true,
                    title: Text(
                      'Third Screen',
                    ),
                  ),
                  body: Container(
                    child: UserList(
                      controller: controller,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
