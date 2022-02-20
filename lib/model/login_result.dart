import 'package:suitcore_screen_test/data/remote/wrapper/model_factory.dart';

import 'user.dart';

class LoginResult implements ModelFactory {
  final String? token;

  const LoginResult({
    this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {'token': this.token};
}
