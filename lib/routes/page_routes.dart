import 'package:get/get.dart';
import 'package:suitcore_screen_test/binding/first_binding.dart';
import 'package:suitcore_screen_test/binding/second_binding.dart';
import 'package:suitcore_screen_test/binding/third_binding.dart';
import 'package:suitcore_screen_test/feature/first/first_controller.dart';
import 'package:suitcore_screen_test/feature/first/first_page.dart';
import 'package:suitcore_screen_test/feature/loader/loading_page.dart';
import 'package:suitcore_screen_test/feature/other/other_page.dart';
import 'package:suitcore_screen_test/feature/second/second_page.dart';
import 'package:suitcore_screen_test/feature/third/third_page.dart';
import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.LOADER,
      page: () => LoadingPage(),
    ),
    GetPage(name: PageName.OTHER, page: () => OtherPage()),
    GetPage(
      name: PageName.FIRST,
      page: () => FirstPage(),
      binding: FirstBinding(),
    ),
    GetPage(
      name: PageName.SECOND,
      page: () => SecondPage(),
      binding: SecondBinding(),
    ),
    GetPage(
      name: PageName.THIRD,
      page: () => ThirdPage(),
      binding: ThirdBinding(),
    ),
  ];
}
