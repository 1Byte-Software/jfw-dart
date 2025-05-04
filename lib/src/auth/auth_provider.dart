abstract class AuthProvider {
  Future<Map<String, String>> getAuthHeaders();
  Future<void> handleUnauthorized();
  bool get isAuthenticated;
}
