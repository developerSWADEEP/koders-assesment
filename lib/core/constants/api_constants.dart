class ApiConstants {
  ApiConstants._();

  // Base URL - Using JSONPlaceholder as public REST API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Endpoints
  static const String posts = '/posts';
  static const String users = '/users';
  static const String comments = '/comments';

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

