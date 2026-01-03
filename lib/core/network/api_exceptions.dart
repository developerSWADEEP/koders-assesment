class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException({String message = 'No internet connection'})
      : super(message: message);
}

class TimeoutException extends ApiException {
  TimeoutException({String message = 'Request timeout'})
      : super(message: message);
}

class ServerException extends ApiException {
  ServerException({
    String message = 'Server error occurred',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({String message = 'Unauthorized access'})
      : super(message: message, statusCode: 401);
}

class NotFoundException extends ApiException {
  NotFoundException({String message = 'Resource not found'})
      : super(message: message, statusCode: 404);
}

class BadRequestException extends ApiException {
  BadRequestException({
    String message = 'Bad request',
    dynamic data,
  }) : super(message: message, statusCode: 400, data: data);
}

