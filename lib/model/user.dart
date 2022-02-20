import 'package:hive/hive.dart';
import 'package:suitcore_screen_test/data/local/hive/hive_types.dart';
import 'package:suitcore_screen_test/data/remote/wrapper/model_factory.dart';

part 'user.g.dart';

@HiveType(typeId: HiveTypes.user)
class User extends HiveObject implements ModelFactory {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? firstName;
  @HiveField(3)
  String? lastName;
  @HiveField(4)
  String? avatarUrl;

  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatarUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatarUrl = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatarUrl;
    return data;
  }
}
