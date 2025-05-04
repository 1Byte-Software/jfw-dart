class UserRoutes {
  // Base URI for user-related API endpoints
  static const String baseUri = 'api/v1/users';

  static String getUserById(String userId) => '$baseUri/$userId';

  static String getCurrentUser() => '$baseUri/me';

  static String getUsers(String query) => '$baseUri?$query';

  static String updateUser(String userId) => '$baseUri/$userId';

  static String addDevice(String userId, String deviceId) =>
      '$baseUri/$userId/devices/$deviceId';

  static String removeDevice(String userId, String deviceId) =>
      '$baseUri/$userId/devices/$deviceId';

  static String getDevicesByUserId(String userId) => '$baseUri/$userId/devices';

  static String forgotPassword() => '$baseUri/forgot-password';

  static String resetPassword() => '$baseUri/reset-password';

  static String changePassword() => '$baseUri/change-password';
}
