import 'package:hive/hive.dart';
import 'package:suitcore_screen_test/model/user.dart';

class HiveAdapters {
  void registerAdapter() {
    Hive.registerAdapter<User>(UserAdapter());
  }
}
