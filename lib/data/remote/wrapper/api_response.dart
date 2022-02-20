import 'package:json_annotation/json_annotation.dart';
import 'package:suitcore_screen_test/data/remote/wrapper/base_response.dart';
import 'model_factory.dart';

@JsonSerializable()
class ApiResponse<T> extends BaseResponse {
  @JsonKey(name: "data")
  @_Converter()
  final T? data;

  ApiResponse({
    this.data,
  }) : super();

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApiResponse<T>(data: _Converter<T?>().fromJson(json["data"]));
  }
}

@JsonSerializable()
class ApiResponses<T> extends BaseResponse {
  @JsonKey(name: "data")
  @_Converter()
  List<T>? data;

  ApiResponses({
    this.data = const [],
  });

  factory ApiResponses.fromJson(Map<String, dynamic> json) => ApiResponses<T>(
      data:
          List<T>.from(json["data"].map((x) => _Converter<T?>().fromJson(x))));
}

class _Converter<T> implements JsonConverter<T?, Object?> {
  const _Converter();

  @override
  T? fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      return ModelFactory.fromJson(T, json) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T? object) {
    return (object as Object);
  }
}
