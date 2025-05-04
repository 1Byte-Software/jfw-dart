import 'package:jfw_dart/src/features/device/constants/device_status.dart';
import 'package:jfw_dart/src/features/device/constants/user_device_status.dart';

class Device {
  String? phoneNumber;
  String? name;
  String? osDevice;
  String? appVersionNumber;
  String? iccid;
  String? imsi;
  String? imei;
  String? simCardInfo;
  DeviceStatus? status;

  Device({
    this.phoneNumber,
    this.name,
    this.osDevice,
    this.appVersionNumber,
    this.iccid,
    this.imsi,
    this.imei,
    this.simCardInfo,
    this.status,
  });

  Device.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    osDevice = json['osDevice'];
    appVersionNumber = json['appVersionNumber'];
    iccid = json['iccid'];
    imsi = json['imsi'];
    imei = json['imei'];
    simCardInfo = json['simCardInfo'];
    status = json['status'] != null
        ? DeviceStatus.values
            .firstWhere((e) => e.name == json['status'] as String)
        : null;
  }
}

class UserDevice extends Device {
  String session;
  String? token;
  UserDeviceStatus userDeviceStatus;

  UserDevice({
    required this.session,
    this.token,
    required this.userDeviceStatus,
    String? phoneNumber,
    String? name,
    String? osDevice,
    String? appVersionNumber,
    String? iccid,
    String? imsi,
    String? imei,
    String? simCardInfo,
    DeviceStatus? status,
  }) : super(
          phoneNumber: phoneNumber,
          name: name,
          osDevice: osDevice,
          appVersionNumber: appVersionNumber,
          iccid: iccid,
          imsi: imsi,
          imei: imei,
          simCardInfo: simCardInfo,
          status: status,
        );

  UserDevice.fromJson(Map<String, dynamic> json)
      : session = json['session'],
        token = json['token'],
        userDeviceStatus = json['userDeviceStatus'] != null
            ? UserDeviceStatus.values
                .firstWhere((e) => e.name == json['userDeviceStatus'] as String)
            : UserDeviceStatus.Offline,
        super.fromJson(json);
}
