// A custom exception class used to handle application-specific errors.
// This class allows for the inclusion of an error message and an optional
// error code, making it easier to identify and handle specific exceptions
// throughout the application.
class AppException implements Exception {
  final String message;
  final int? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}
