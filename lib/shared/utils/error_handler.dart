import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:wave_app/shared/utils/functions.dart';

class ErrorHandler {
  static Future<bool> handleError(
    Object e, {
    bool? showTost,
    dynamic s,
  }) async {
    // log(s.toString());

    if (e is DioException) {
      log((e.response?.statusCode ?? 0).toString());
      log(e.response.toString());
      log(e.requestOptions.path);
      if (e.type == DioExceptionType.connectionTimeout) {
        final ConnectivityResult result =
            await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) {
          showToast(
              text: 'يرجى التأكد من اتصالك بالإنترنت',
              state: ToastStates.WARNING);

          return false;
        } else {
          showToast(text: 'حدث خطأ!', state: ToastStates.ERROR);
          return false;
        }
      }
      if (e.type == DioExceptionType.connectionError) {
        final ConnectivityResult result =
            await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) {
          showToast(
              text: 'يرجى التأكد من اتصالك بالإنترنت',
              state: ToastStates.WARNING);
          return false;
        } else {
          showToast(
              text: 'يرجى التأكد من اتصالك بالإنترنت',
              state: ToastStates.WARNING);
          return false;
        }
      }
      if (e.response != null && showTost == null) {
        if (e.response?.data['message'] is String) {
          if (e.response?.data['message']
                  .toString()
                  .contains('Unauthenticated') ==
              true) {
            // HiveController.setToken(null);
            return true;
          }

          showToast(
              text: e.response!.data['message'].toString(),
              state: ToastStates.ERROR);
        } else {
          Map? map = e.response?.data['message'];
          StringBuffer errors = StringBuffer();
          map?.forEach((key, value) {
            if (value is List) {
              for (var element in value) {
                errors.write(element);
                errors.write('\n');
              }
            }
            errors.toString().substring(0, errors.toString().length - 3);
          });

          showToast(text: errors.toString(), state: ToastStates.ERROR);
        }
      } else {
        final ConnectivityResult result =
            await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) {
          showToast(
              text: 'يرجى التأكد من اتصالك بالإنترنت',
              state: ToastStates.WARNING);
          return false;
        } else {
          //  showMessage('حدث خطأ', 2);
          return false;
        }
      }
      return true;
    } else {
      log("ErrorHandler else ==> $e");

      return true;
    }
  }
}
