class AppConstants {
  AppConstants._();

  static const String appName = 'Koders Assessment';
  static const String appVersion = '1.0.0';

  // Pagination
  static const int pageSize = 10;
  static const int initialPage = 1;

  // Animation durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration snackbarDuration = Duration(seconds: 3);

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

