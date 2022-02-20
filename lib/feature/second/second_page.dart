import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suitcore_screen_test/feature/second/second_controller.dart';
import 'package:suitcore_screen_test/routes/page_names.dart';
import 'package:suitcore_screen_test/utills/widget/primary_button.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(PageName.OTHER),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: GetBuilder<SecondController>(
            init: SecondController(),
            initState: (_) {},
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('txt_welcome'.tr),
                      Text(
                        "${controller.currentUser.firstName} ${controller.currentUser.lastName}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Text(
                          "${controller.userData.firstName} ${controller.userData.lastName}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    title: 'txt_choose_user'.tr,
                    onPressed: () {
                      controller.goToChooseUser();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
