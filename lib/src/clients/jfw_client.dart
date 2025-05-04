import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jfw_dart/src/exceptions/jfw_exception.dart';
import 'package:jfw_dart/src/types/api_response.dart';
import '../auth/auth_provider.dart';

// The JfwClient class is responsible for making HTTP requests to the JFW API.
class JfwClient {
  final String baseUrl;
  final String brandUrl;
  AuthProvider authProvider;
  final http.Client httpClient;

  // Constants key headers
  static const String brandUrlHeader = 'BrandUrl';
  static const String authKeyHeader = 'AuthKey';
  static const String apiKeyHeader = 'APIKey';

  // Base URL for the JFW API with a default value
  // This can be overridden by passing a different base URL to the constructor
  // The default base URL is set to the live environment
  // In the future, this value can be replace with the baseUrl of the brand. And we make the baseUrl in the constructor is required
  static const String baseUrlLive = 'https://protocol.jframework.io';

  JfwClient({
    String? baseUrl,
    required this.authProvider,
    required this.brandUrl,
    http.Client? client,
  })  : baseUrl = baseUrl ?? baseUrlLive,
        httpClient = client ?? http.Client();

  // Update client to use the new AuthProvider
  void updateAuthProvider(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
  }

  // Handle errors from the API response
  // This method will throw a JfwException with the error message and status code
  JfwException handleError(ApiResponse response) {
    List<ErrorResponse> errors = response.errors ?? [];

    String errorMessage =
        errors.isNotEmpty ? errors[0].details : 'An unknown error occurred';

    return JfwException(
      message: errorMessage,
      statusCode: response.statusCode,
    );
  }

  // Handle API requests
  // This method will be used for GET, POST, PUT, DELETE requests
  Future<http.Response> request({
    required String method,
    required String path,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$path');
      final requestHeaders = await authProvider.getAuthHeaders();

      // Add the brand URL to the headers
      requestHeaders[brandUrlHeader] = brandUrl;

      final response = await httpClient.send(
        http.Request(method, uri)
          ..headers.addAll({...requestHeaders, ...?headers})
          ..body = body != null ? json.encode(body) : '',
      );

      if (response.statusCode == 401) {
        await authProvider.handleUnauthorized();
      }

      return http.Response.fromStream(response);
    } catch (e) {
      // Handle any exceptions that occur during the request
      throw JfwException(
        message: 'An error occurred while making the request: $e',
        statusCode: 500,
      );
    }
  }

  // Generic method to handle API requests and responses
  // This method will be used for GET, POST, PUT, DELETE requests
  // It takes the HTTP method, path, body, headers, and a function to parse the response
  // into the desired type
  Future<ApiResponse<T>> requestWithResponse<T>(
      String method,
      String path,
      dynamic body,
      Map<String, String>? headers,
      T Function(Map<String, dynamic>) fromJsonT) async {
    final response = await request(method: method, path: path, body: body);
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final apiResult = ApiResponse<T>.fromJson(jsonResponse, fromJsonT);

    if (apiResult.isError()) {
      throw handleError(apiResult);
    }

    return apiResult;
  }

  // Handle GET requests
  Future<ApiResponse<T>> get<T>(
      String path, T Function(Map<String, dynamic>) fromJsonT) async {
    return await requestWithResponse(
      'GET',
      path,
      null,
      null,
      fromJsonT,
    );
  }

  // Handle POST requests
  Future<ApiResponse<T>> post<T>(String path, dynamic body,
      T Function(Map<String, dynamic>) fromJsonT) async {
    return await requestWithResponse(
      'POST',
      path,
      body,
      null,
      fromJsonT,
    );
  }

  // Upload files using multipart/form-data
  Future<ApiResponse<T>> postMultipartRequest<T>(
      String path,
      Map<String, String> fields,
      List<http.MultipartFile> files,
      T Function(Map<String, dynamic>) fromJsonT) async {
    final uri = Uri.parse('$baseUrl/$path');
    final request = http.MultipartRequest('POST', uri);

    // Add the brand URL to the headers
    request.headers[brandUrlHeader] = brandUrl;
    request.headers.addAll(await authProvider.getAuthHeaders());
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields.addAll(fields);
    request.files.addAll(files);

    final response = await httpClient.send(request);
    final responseBody = await http.Response.fromStream(response);

    final Map<String, dynamic> jsonResponse = json.decode(responseBody.body);
    final apiResult = ApiResponse<T>.fromJson(jsonResponse, fromJsonT);

    if (apiResult.isError()) {
      throw handleError(apiResult);
    }

    return apiResult;
  }

  // Handle PUT requests
  Future<ApiResponse<T>> put<T>(String path, dynamic body,
      T Function(Map<String, dynamic>) fromJsonT) async {
    return await requestWithResponse(
      'PUT',
      path,
      body,
      null,
      fromJsonT,
    );
  }

  // Handle DELETE requests
  Future<ApiResponse<T>> delete<T>(
      String path, T Function(Map<String, dynamic>) fromJsonT) async {
    return await requestWithResponse(
      'DELETE',
      path,
      null,
      null,
      fromJsonT,
    );
  }

  // Close the HTTP client
  // This method should be called when the client is no longer needed
  Future<void> close() async {
    httpClient.close();
  }
}
