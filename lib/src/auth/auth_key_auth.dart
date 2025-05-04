import 'package:jfw_dart/jfw.dart';

class AuthKeyProvider implements AuthProvider {
  final String? _authKey;
  AuthKeyProvider(this._authKey);

  @override
  Future<Map<String, String>> getAuthHeaders() async {
    final token = _authKey;

    return {
      if (token != null) JfwClient.authKeyHeader: token,
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<void> handleUnauthorized() async {}

  @override
  bool get isAuthenticated => _authKey != null;
}
