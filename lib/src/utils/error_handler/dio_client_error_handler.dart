import 'dart:convert';
import 'package:dio/dio.dart' hide DioErrorType;
import 'package:itunes_teya_test/src/utils/error_handler/dio_error_type.dart';
import 'package:itunes_teya_test/src/utils/error_handler/app_exception.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger();

class DioClientErrorHandler {
  final Dio _dio;

  DioClientErrorHandler({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              responseType: ResponseType.json,
            ),
          ) {
    if (dio == null) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
    }
  }

  Future<Map<String, dynamic>> getJson(String url) async {
    try {
      final response = await _dio.get(url);

      try {
        final decoded = jsonDecode(response.data as String);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
      } catch (e) {
        _logger.e("Error decoding JSON string", error: e);
        throw AppException(
          message: DioErrorType.parseError.message,
          code: DioErrorType.parseError.code,
        );
      }
      throw AppException(
        message: DioErrorType.parseError.message,
        code: DioErrorType.parseError.code,
      );
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      _logger.e("Unexpected error", error: e, stackTrace: stackTrace);
      throw AppException(
        message: DioErrorType.unknown.message,
        code: DioErrorType.unknown.code,
      );
    }
  }

  AppException _handleDioError(DioException error) {
    _logger.e("DioException Type: ${error.type}");
    _logger.e("DioException Message: ${error.message}");
    _logger.e("DioException Error: ${error.error}");

    final errorType = switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => DioErrorType.networkError,
      DioExceptionType.badResponse => _getHttpErrorFromResponse(error.response),
      DioExceptionType.connectionError => DioErrorType.networkError,
      DioExceptionType.badCertificate => DioErrorType.networkError,
      DioExceptionType.cancel => DioErrorType.unknown,
      DioExceptionType.unknown => DioErrorType.networkError,
    };

    return AppException(message: errorType.message, code: errorType.code);
  }

  DioErrorType _getHttpErrorFromResponse(Response? response) {
    if (response == null) return DioErrorType.unknown;
    return DioErrorType.fromStatusCode(response.statusCode ?? 0);
  }

  void dispose() {
    _dio.close();
  }
}
