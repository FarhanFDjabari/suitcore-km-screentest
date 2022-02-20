import 'dart:io';
import 'package:dio/dio.dart';
import 'package:suitcore_screen_test/data/remote/errorhandler/network_exception.dart';
import 'package:suitcore_screen_test/data/remote/wrapper/api_response.dart';
import 'package:suitcore_screen_test/data/remote/wrapper/base_response.dart';
import 'package:suitcore_screen_test/feature/auth/auth_controller.dart';

class ErrorHandler {
  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.connectTimeout:
              networkExceptions = NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                  networkExceptions = NetworkExceptions.badRequest();
                  break;
                case 401:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 403:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 404:
                  networkExceptions = NetworkExceptions.notFound("Not found");
                  break;
                case 409:
                  networkExceptions = NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = NetworkExceptions.requestTimeout();
                  break;
                case 500:
                  networkExceptions = NetworkExceptions.internalServerError();
                  break;
                case 503:
                  networkExceptions = NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
            case DioErrorType.cancel:
              networkExceptions = NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.other:
              networkExceptions = NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        // Helper.printError(e.toString());
        return NetworkExceptions.formatException();
      } catch (_) {
        return NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptions.unableToProcess();
      } else {
        return NetworkExceptions.defaultError(error.toString());
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "Not Implemented";
    }, requestCancelled: () {
      errorMessage = "Request Cancelled";
    }, internalServerError: () {
      errorMessage = "Internal Server Error";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "Service unavailable";
    }, methodNotAllowed: () {
      errorMessage = "Method Allowed";
    }, badRequest: () {
      errorMessage = "Bad request";
    }, unauthorisedRequest: () {
      errorMessage = "Unauthorised request";
      AuthController.find.signOut();
    }, unexpectedError: () {
      errorMessage = "Unexpected error occurred";
    }, requestTimeout: () {
      errorMessage = "Connection request timeout";
    }, noInternetConnection: () {
      errorMessage = "No internet connection";
    }, conflict: () {
      errorMessage = "Error due to a conflict";
    }, sendTimeout: () {
      errorMessage = "Send timeout in connection with API server";
    }, unableToProcess: () {
      errorMessage = "Unable to process the data";
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "Unexpected error occurred";
    }, notAcceptable: () {
      errorMessage = "Not acceptable";
    });
    return errorMessage;
  }
}

extension FutureAPIResultExt<T extends BaseResponse> on Future<T> {
  Future<T> validateStatus() {
    return then((value) async {
      final code = value.status!;
      final message = value.message!;
      // You can use this if has multiple domain url and separate the error
      // final domain = value.domain;
      // debugPrint("DOMAIN => $domain");
      if (code >= 200 && code <= 299) return value;
      if (code == 401) {
        AuthController.find.signOut();
      }
      throw message;
    });
  }

  Future<T> validateData() {
    return then((value) {
      const error = 'Terjadi kesalahan dalam koneksi';
      if (value is ApiResponse) {
        if (value.data != null) {
          return value;
        } else {
          throw error;
        }
      }
      if (value is ApiResponses) {
        if (value.data != null) {
          return value;
        } else {
          throw error;
        }
      }
      return value;
    });
  }

  Future<T> validateResponse() {
    return validateStatus().validateData();
  }
}

extension FutureExt<T> on Future<T> {
  Future<T> summarizeError() {
    return catchError((error) async {
      throw ErrorHandler.getErrorMessage(ErrorHandler.getDioException(error));
    });
  }

  Future<T> handleError(Function onError) async {
    return summarizeError().catchError(onError);
  }
}