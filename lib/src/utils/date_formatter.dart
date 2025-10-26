import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

// Formats a UTC date string into the format 'dd/MM/yyyy' removing hours and minutes.

final Logger _logger = Logger();

class DateFormatter implements Exception {
  final String message;
  DateFormatter(this.message);

  @override
  String toString() => 'DateFormattingException: $message';
}

String formatUtcDateToYyyyMmDd(
  String? dateUtc, {
  String outputFormat = 'dd/MM/yyyy',
}) {
  if (dateUtc == null || dateUtc.isEmpty) {
    throw DateFormatter('Input date is null or empty');
  }
  try {
    final DateTime date = DateTime.parse(dateUtc);
    return DateFormat(outputFormat).format(date);
  } catch (e) {
    _logger.e('Error formatting date: $e');
    throw DateFormatter('Error parsing or formatting date: $e');
  }
}
