import 'dart:io';

import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/auth/auth_key_auth.dart';

void main() async {
  // Option 1: Auth Key Authentication.
  final authKey = "YOUR_AUTH_KEY"; // This value is will be generated before call authService.loginWithCredentials()
  final brandUrl = "YOUR_BRAND_URL";

  final authProvider = AuthKeyProvider(authKey);

  final client = JfwClient(
    brandUrl: brandUrl,
    authProvider: authProvider,
  );

  final cdnService = CdnService(client);

  try {

    final file = new File('example.jpg');

    final request = UploadCdnRequest(
      uploadFile: file,
      prefixFolder: 'tests',
      refObject: 'example',
      refId: 1000

    );

    if(!await file.exists()){
      throw Exception('File not found');
    }

    // Call the API to get the current user
    final response = await cdnService.uploadFile(request);

    print('Result fileId: ${response.fileId}');
    print('Result url: ${response.url}');

  } catch (e) {
    print('Error: ${e}');
  }
}
