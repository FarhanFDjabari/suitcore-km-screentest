import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suitcore_screen_test/feature/first/first_controller.dart';
import 'package:suitcore_screen_test/gen/assets.gen.dart';
import 'package:suitcore_screen_test/utills/helper/validator.dart';
import 'package:suitcore_screen_test/utills/widget/forms/form_input_field_with_icon.dart';
import 'package:suitcore_screen_test/utills/widget/primary_button.dart';
import 'package:suitcore_screen_test/utills/widget/statefull_wrapper.dart';

class FirstPage extends GetView<FirstController> {
  FirstPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () async {},
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                Assets.lib.resources.images.background.assetName,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 20,
                ),
                child: GetBuilder<FirstController>(
                  init: FirstController(),
                  initState: (_) {},
                  builder: (_) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.lib.resources.images.imgEmpty.assetName,
                            width: 116,
                            colorBlendMode: BlendMode.overlay,
                          ),
                          const SizedBox(height: 45),
                          FormInputFieldWithIcon(
                            onChanged: (value) {},
                            onSaved: (value) {
                              controller.nameController.text = value!;
                            },
                            controller: controller.nameController,
                            labelText: 'Name',
                            iconPrefix: Icons.person,
                            validator: Validator().name,
                          ),
                          const SizedBox(height: 15),
                          FormInputFieldWithIcon(
                            onChanged: (value) {},
                            onSaved: (value) {
                              controller.palindromeController.text = value!;
                            },
                            controller: controller.palindromeController,
                            labelText: 'Palindrome Check',
                            iconPrefix: Icons.text_fields,
                            validator: null,
                          ),
                          const SizedBox(height: 30),
                          PrimaryButton(
                            title: 'txt_check_palindrome'.tr.toUpperCase(),
                            onPressed: controller.isLoading
                                ? null
                                : () {
                                    controller.checkPalindrome();
                                  },
                          ),
                          const SizedBox(height: 10),
                          PrimaryButton(
                            title: 'txt_button_login'.tr.toUpperCase(),
                            child: controller.isLoading
                                ? CircularProgressIndicator()
                                : null,
                            onPressed: controller.isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate())
                                      controller.bypassLogin();
                                  },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
