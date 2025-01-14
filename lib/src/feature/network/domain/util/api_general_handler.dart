import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// API errors handler for `APIRequestsRepositoryImpl`
class APIRequestHandlers {
  /// General request errors handler for responses status code other than 200
  void requestException(http.Response response) {
    if (kDebugMode) {
      print(response.body.toString());
    }
    switch (response.statusCode) {
      default:
    }
    _logAnalyticsEvent();
  }

  /// General API Client exceptions handler
  /// Such as a connection error
  void noResponseRequestException(dynamic exception) {
    if (kDebugMode) {
      print(exception.toString());
    }
    _logAnalyticsEvent();
  }

  /// General API unknown errors handler
  /// Handles cases where unexpected error happening
  void unknownRequestException(dynamic exception) {
    if (kDebugMode) {
      print(exception.toString());
    }
    _logAnalyticsEvent();
  }

  /// Internal calls for General API errors logger
  /// Such as 'Firebase Crashlytics' or our 'internal server logs'
  static void _logAnalyticsEvent() {
    /// Log request exceptions
  }
}
