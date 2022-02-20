import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suitcore_screen_test/model/login_request.dart';
import 'package:suitcore_screen_test/model/login_result.dart';
import 'package:suitcore_screen_test/model/user.dart';
import 'environment.dart';
import 'interceptor/dio.dart';
import 'wrapper/api_response.dart';

part 'api_services.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static Future<RestClient> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    return RestClient(
      await AppDio().getDIO(
          headers: headers,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @GET("/api/users")
  Future<ApiResponses<User>> getUsers(@Query("page") int page);

  @GET("/api/users/{id}")
  Future<ApiResponse<User>> getUserDetail(@Path("id") int id);
}

final client = RestClient.create();
