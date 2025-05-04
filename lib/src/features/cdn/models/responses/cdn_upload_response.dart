
class CdnUploadResponse {
  final String fileId;
  final String fileName;
  final String originalFileName;
  String? prefixFolder;
  final String relativeUrl;
  final String url;
  final String fileUrl;
  final String fileExtension;
  final String mimeType;
  final int fileSize;
  final bool testMode;

  CdnUploadResponse({
    required this.fileId,
    required this.fileName,
    required this.originalFileName,
    this.prefixFolder,
    required this.relativeUrl,
    required this.url,
    required this.fileUrl,
    required this.fileExtension,
    required this.mimeType,
    required this.fileSize,
    required this.testMode,
  });
  factory CdnUploadResponse.fromJson(Map<String, dynamic> json) {
    return CdnUploadResponse(
      fileId: json['fileId'] as String,
      fileName: json['fileName'] as String,
      originalFileName: json['originalFilename'] as String,
      prefixFolder: json['prefixFolder'] as String?,
      relativeUrl: json['relativeUrl'] as String,
      url: json['url'] as String,
      fileUrl: json['fileUrl'] as String,
      fileExtension: json['fileExtension'] as String,
      mimeType: json['mimeType'] as String,
      fileSize: json['fileSize'] as int,
      testMode: json['testMode'] as bool,
    );
  }
}
