// This file defines the ApiResponse class, which is used to represent the response from an API call.
class ApiResponse<T> {
  // The data returned from the API
  // This is a generic type, so it can be any type
  final T? data;

  // True if the request was successful
  // False if the request failed
  final bool success;

  // Status code
  final int statusCode;

  // Array of errors
  final List<ErrorResponse>? errors;

  ApiResponse({
    required this.data,
    required this.success,
    required this.statusCode,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final data = json['data'] != null ? fromJsonT(json['data']) : null;
    final success = json['success'] as bool;
    final statusCode = json['statusCode'] as int;

    // Maps the errors to a list of ErrorResponse objects
    final errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => ErrorResponse.fromJson(e as Map<String, dynamic>))
        .toList();

    return ApiResponse(
      data: data,
      success: success,
      statusCode: statusCode,
      errors: errors,
    );
  }

  /// Function to check if the response is successful
  bool isSuccessful() {
    return success && statusCode >= 200 && statusCode < 300;
  }

  /// Function to check if the response is an error
  /// This is the opposite of isSuccessful
  bool isError() {
    return !isSuccessful();
  }
}

class ErrorResponse {
  final int code;
  final int subCode;
  final int errorCode;
  final String details;

  ErrorResponse({
    required this.code,
    required this.subCode,
    required this.errorCode,
    required this.details,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      code: json['code'] as int,
      subCode: json['subcode'] as int,
      errorCode: json['errorCode'] as int,
      details: json['details'] as String,
    );
  }
}
