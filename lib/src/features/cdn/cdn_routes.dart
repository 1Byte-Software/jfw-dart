class CdnRoutes {
  // Base URI for user-related API endpoints
  static const String baseUri = 'api/cdn';

  static String uploadFile() => '$baseUri/upload-file';

  static String getFilesCdn(String query) => '$baseUri?$query';

  static String getById(String fileId) => '$baseUri/$fileId';
}
