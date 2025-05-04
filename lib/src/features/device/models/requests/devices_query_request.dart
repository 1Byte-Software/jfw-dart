import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/models/requests/pagination_request.dart';

class DeviceQueryRequest extends PaginationRequest {
  String? userId;
  String? code;
  String? deviceName;
  String? deviceToken;
  bool? isMobileApp;
  DeviceStatus? status;
  bool? testMode;

  DeviceQueryRequest({
    this.userId,
    this.code,
    this.deviceName,
    this.deviceToken,
    this.isMobileApp,
    this.status,
    this.testMode,
    int? pageNumber,
    int? pageSize,
  }) : super(pageNumber: pageNumber, pageSize: pageSize);

  String toQueryString() {
    final queryParameters = {
      if (userId != null) 'userId': userId,
      if (code != null) 'code': code,
      if (deviceName != null) 'deviceName': deviceName,
      if (deviceToken != null) 'deviceToken': deviceToken,
      if (isMobileApp != null) 'isMobileApp': isMobileApp,
      if (status != null) 'status': status.toString(),
      if (testMode != null) 'testMode': testMode,
      ...super.toQueryParam(),
    };

    return queryParameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }
}
