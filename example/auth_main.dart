import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/auth/auth_key_auth.dart';

void main() async {

  final brandUrl = "YOUR_BRAND_URL";

  // Option 1: Auth Key Authentication
  final authProvider = AuthKeyProvider(null);

  // Option 2: API Key Authentication
  // final authProvider = ApiKeyProvider('your-api-key-here');

  final client = JfwClient(
    brandUrl: brandUrl,
    authProvider: authProvider,
  );

  final authService = AuthService(client);

  try {
    // Instantiate the request with the required parameters
    AuthenticateRequest request = AuthenticateRequest(
      username: 'username', // Replace with your username
      password: 'password', // Replace with your password
    );

    // Login with credentials
    final response = await authService.loginWithCredentials(request);

    // If the login is successful, the response will contain the auth key
    client.updateAuthProvider(AuthKeyProvider(response.authKey));

    print('Login successful! Auth Key: ${response.authKey}');

    // Subsequent requests will automatically include the Auth-Key header
    final userService = UserService(client);
    final user = await userService.getCurrentUser();
    print('Current user: id=${user.id}, email=${user.emailAddress}, username=${user.username}');
  } catch (e) {
    print('Error: $e');
  }
}
