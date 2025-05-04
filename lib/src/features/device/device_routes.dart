class DeviceRoutes {
  // Base URI for user-related API endpoints
  static const String baseUri = 'api/devices';

  static String getById(String fileId) => '$baseUri/$fileId';

  static String getDevices(String query) => '$baseUri?$query';
}
