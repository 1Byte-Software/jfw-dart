import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/types/pagination.dart';

class DeviceService {
  final JfwClient _client;

  DeviceService(this._client);

  // Create a new device
  // This method creates a new device using the provided DeviceCommandRequest.
  // It sends a POST request to the API endpoint 'api/devices' with the request body.
  // The response is parsed into a Device object and returned.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/devices/create-a-device
  // @param deviceCommandRequest The request object containing device details.
  // @return A Future that resolves to a Device object.
  Future<Device> create(
    DeviceCommandRequest deviceCommandRequest,
  ) async {
    final apiResponse = await _client.post<Device>(
      DeviceRoutes.baseUri,
      deviceCommandRequest.toJson(),
      Device.fromJson,
    );
    return apiResponse.data!;
  }

  // Get a device by ID
  // This method retrieves a device by its ID from the API.
  // It sends a GET request to the API endpoint 'api/devices/{deviceId}'.
  // The response is parsed into a Device object and returned.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/devices/get-a-device
  // @param deviceId The ID of the device to be retrieved.
  // @return A Future that resolves to a Device object.
  Future<Device> getById(String deviceId) async {
    final apiResponse = await _client.get<Device>(
        DeviceRoutes.getById(deviceId), Device.fromJson);
    return apiResponse.data!;
  }

  // Get a list of devices based on the provided query parameters
  // This method retrieves a paginated list of devices from the API.
  // It accepts a DeviceQueryRequest object containing the query parameters.
  // The response is parsed into a Pagination<Device> object.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/devices/get-devices
  // @param query The DeviceQueryRequest object containing the query parameters.
  // @return A Future that resolves to a Pagination<Device> object containing the list of devices.
  Future<Pagination<Device>> getDevices({
    required DeviceQueryRequest query,
  }) async {
    final queryString = query.toQueryString();
    final apiResponse = await _client.get<Pagination<Device>>(
      DeviceRoutes.getDevices(queryString),
      (json) => Pagination<Device>.fromJson(json, Device.fromJson),
    );

    return apiResponse.data!;
  }
}
