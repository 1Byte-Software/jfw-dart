import 'package:jfw_dart/jfw.dart';

class ApiKeyProvider implements AuthProvider {
  final String apiKey;

  ApiKeyProvider(this.apiKey);

  @override
  Future<Map<String, String>> getAuthHeaders() async {
    return {
      JfwClient.apiKeyHeader: apiKey,
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<void> handleUnauthorized() async {
    // API Key doesn't change on unauthorized
    // You might want to implement a refresh logic here if needed
  }

  @override
  bool get isAuthenticated => true;
}
