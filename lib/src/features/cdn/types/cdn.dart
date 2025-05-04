import 'package:jfw_dart/src/features/user/types/base_user.dart';

class Cdn {
  final BaseUser? user;
  final String? refObject;
  final int? refId;
  final String? mimeType;
  final String fileUrl;
  final String originalFileName;
  final String? notes;
  final String? tags;

  Cdn({
    this.user,
    this.refObject,
    this.refId,
    this.mimeType,
    required this.fileUrl,
    required this.originalFileName,
    this.notes,
    this.tags,
  });

  factory Cdn.fromJson(Map<String, dynamic> json) {
    return Cdn(
      user: json['user'] != null ? BaseUser.fromJson(json['user']) : null,
      refObject: json['refObject'] as String?,
      refId: json['refId'] as int?,
      mimeType: json['mimeType'] as String?,
      fileUrl: json['fileUrl'] as String,
      originalFileName: json['originalFilename'] as String,
      notes: json['notes'] as String?,
      tags: json['tags'] as String?,
    );
  }
}
