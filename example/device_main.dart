import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/auth/auth_key_auth.dart';

void main() async {
  // Auth Key Authentication.
  final authKey = "H+a+SZuunxY2qcvmC1B3yj3BuenCit1IeVRaazFsRGNXR21UZjA2c3JiTElaZz09cVIyeElZRmdMODZoV1RoVmFlMHJwZzc0NmordE5EZmxXRS9BU0JzdWtLaz0="; // This value is will be generated before call authService.loginWithCredentials()
  final brandUrl = "my.boostpte.com";

  final authProvider = AuthKeyProvider(authKey);

  final client = JfwClient(
    brandUrl: brandUrl,
    authProvider: authProvider,
  );

  final deviceService = DeviceService(client);

  try {

    final query = DeviceQueryRequest(
      pageNumber: 0,
      pageSize: 10,
    );

    // Call the API to get the current user
    final response = await deviceService.getDevices(query: query);

    print('Result total items: ${response.totalItems}');

    for (var item in response.items) {
      print('name=${item.name},  os=${item.osDevice}, status=${item.status}');
    }

  } catch (e) {
    print('Error: ${e}');
  }
}
