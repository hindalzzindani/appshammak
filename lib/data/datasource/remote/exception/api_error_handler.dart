import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shammak_ecommerce/data/model/response/base/error_response.dart';

import '../../../../localization/language_constrants.dart';

class ApiErrorHandler {
  static BuildContext context;

  
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = getTranslated('Request to API server was cancelled', context);
              break;
            case DioErrorType.connectTimeout:
              errorDescription = getTranslated('Connection timeout with API server', context);
              break;
            case DioErrorType.other:
              errorDescription = getTranslated('Connection to API server failed due to internet connection',context);
              ;
              break;
            case DioErrorType.receiveTimeout:
              errorDescription = getTranslated('Receive timeout in connection with API server',context);
              break;
            case DioErrorType.response:
              switch (error.response.statusCode) {
                case 404:
                case 500:
                case 503:
                  errorDescription = error.response.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse =
                  ErrorResponse.fromJson(error.response.data);
                  if (errorResponse.errors != null &&
                      errorResponse.errors.length > 0)
                    errorDescription = errorResponse;
                  else
                    errorDescription =
                    "Failed to load data - status code: ${error.response.statusCode}";
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = getTranslated('Send timeout with server',context);
              break;
          }
        } else {
          errorDescription = getTranslated('Unexpected error occured',context);
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = getTranslated('is not a subtype of exception',context);
    }
    return errorDescription;
  }
}
