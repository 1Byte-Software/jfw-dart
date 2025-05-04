import 'dart:io';

import 'package:http/http.dart';
import 'package:jfw_dart/src/features/cdn/constants/cdn_path_type.dart';

class UploadCdnRequest {
  String? fileName;
  File uploadFile;
  String? prefixFolder;
  String? refObject;
  int? refId;
  String? notes;
  String? tags;
  CdnPathType? pathType;
  bool testMode = false;

  UploadCdnRequest({
    required this.uploadFile,
    this.fileName,
    this.prefixFolder,
    this.refObject,
    this.refId,
    this.notes,
    this.tags,
    this.pathType,
  });

  // Converts the request to a Map<String, String> for form fields
  Map<String, String> toFormFields() {
    return {
      if (fileName != null) 'fileName': fileName!,
      if (prefixFolder != null) 'prefixFolder': prefixFolder!,
      if (refObject != null) 'refObject': refObject!,
      if (refId != null) 'refId': refId!.toString(),
      if (notes != null) 'notes': notes!,
      if (tags != null) 'tags': tags!,
      if (pathType != null) 'cdnPathType': pathType.toString(),
      'testMode': testMode.toString(),
    };
  }

  // Converts the file to a MultipartFile
  Future<MultipartFile> toMultipartFile() async {
    return MultipartFile.fromPath(
      'uploadFile',
      uploadFile.path,
      filename: fileName ?? uploadFile.path.split('/').last,
    );
  }
}
