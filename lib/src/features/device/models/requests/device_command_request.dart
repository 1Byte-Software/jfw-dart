class DeviceCommandRequest {
  final String code;
  final String name;
  final String osDevice;
  final String appVersionNumber;
  final String? tags;
  final String? iccid;
  final String? imei;
  final String? imsi;
  final String? simCardInfo;
  final bool isMobileApp = true;

  DeviceCommandRequest({
    required this.code,
    required this.name,
    required this.osDevice,
    required this.appVersionNumber,
    this.tags,
    this.iccid,
    this.imei,
    this.imsi,
    this.simCardInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'osDevice': osDevice,
      'appVersionNumber': appVersionNumber,
      'tags': tags,
      'iccid': iccid,
      'imei': imei,
      'imsi': imsi,
      'simCardInfo': simCardInfo,
      'isMobileApp': isMobileApp,
    };
  }
}
