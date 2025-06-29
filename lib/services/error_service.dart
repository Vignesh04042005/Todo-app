import 'package:flutter/foundation.dart';

class ErrorService {
  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    debugPrint('Error occurred: $error');
    // Removed Sentry reporting for now
  }

  static Future<void> reportMessage(String message) async {
    debugPrint('Message: $message');
    // Removed Sentry reporting for now
  }

  static void setUserContext(String userId, String email) {
    debugPrint('User context set: $userId, $email');
    // Removed Sentry user context for now
  }

  static void addBreadcrumb(String message, String category) {
    debugPrint('Breadcrumb [$category]: $message');
    // Removed Sentry breadcrumb for now
  }
} 