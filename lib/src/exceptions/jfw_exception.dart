class JfwException implements Exception {
  // The message of the exception
  final String message;

  // The status code of the exception
  final int statusCode;

  JfwException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() {
    return 'JfwException: $message (Status Code: $statusCode)';
  }
}
