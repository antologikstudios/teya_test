enum DioErrorType {
  badRequest(400),

  notFound(404),

  internalServerError(500),

  networkError(0),

  parseError(0),

  unknown(0);

  const DioErrorType(this.code);

  final int code;

  static DioErrorType fromStatusCode(int statusCode) {
    return switch (statusCode) {
      400 => DioErrorType.badRequest,
      404 => DioErrorType.notFound,
      500 => DioErrorType.internalServerError,
      _ => DioErrorType.unknown,
    };
  }

  String get message {
    return switch (this) {
      DioErrorType.badRequest => "Bad request. Please check your input.",
      DioErrorType.notFound => "Resource not found.",
      DioErrorType.internalServerError =>
        "Server error. Please try again later.",
      DioErrorType.networkError =>
        "Network error. Please check your connection.",
      DioErrorType.parseError => "Invalid response format.",
      DioErrorType.unknown => "An unexpected error occurred.",
    };
  }

  String get technicalMessage {
    return switch (this) {
      DioErrorType.badRequest => "HTTP 400: Bad Request",
      DioErrorType.notFound => "HTTP 404: Not Found",
      DioErrorType.internalServerError => "HTTP 500: Internal Server Error",
      DioErrorType.networkError => "Network connection error",
      DioErrorType.parseError => "JSON parsing error",
      DioErrorType.unknown => "Unknown error",
    };
  }

  bool get shouldRetry {
    return switch (this) {
      DioErrorType.internalServerError || DioErrorType.networkError => true,
      _ => false,
    };
  }
}
