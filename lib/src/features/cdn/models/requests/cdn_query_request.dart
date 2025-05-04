
import 'package:jfw_dart/src/models/requests/pagination_request.dart';

class CdnQueryRequest extends PaginationRequest {
  String? userId;
  String? refObject;
  String? refId;
  String? mimeType;
  String? originalFileName;

  CdnQueryRequest({
    this.userId,
    this.refObject,
    this.refId,
    this.mimeType,
    this.originalFileName,
    int? pageNumber,
    int? pageSize,
  }) : super(pageNumber: pageNumber, pageSize: pageSize);

  String toQueryString() {
    final queryParameters = <String, String?>{
      if (userId != null) 'userId': userId,
      if (refObject != null) 'refObject': refObject,
      if (refId != null) 'refId': refId,
      if (mimeType != null) 'mimeType': mimeType,
      if (originalFileName != null) 'originalFileName': originalFileName,
      ...super.toQueryParam(),
    };

    return queryParameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }
}
