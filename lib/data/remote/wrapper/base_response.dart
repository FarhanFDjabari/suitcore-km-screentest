import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'domain')
  String? domain;

  BaseResponse({this.status, this.message, this.domain});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      status: json["status"], message: json["message"], domain: json["domain"]);

  Map<dynamic, dynamic> toJson() => <String, dynamic>{
        'status': this.status,
        'message': this.message,
      };
}
