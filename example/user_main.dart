import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/auth/auth_key_auth.dart';

void main() async {
  // Option 1: Auth Key Authentication.
  final authKey = "YOUR_AUTH_KEY";
  final brandUrl = "YOUR_BRAND_URL";

  final authProvider = AuthKeyProvider(authKey);

  // Option 2: API Key Authentication
  // final authProvider = ApiKeyProvider('your-api-key-here');


  final client = JfwClient(
    brandUrl: brandUrl,
    authProvider: authProvider,
  );

  final userService = UserService(client);

  try {
    // Call the API to get the current user
    final response = await userService.getCurrentUser();

    print('Result getCurrentUser: ${response.id}');
  } catch (e) {
    print('Error: $e');
  }
}
