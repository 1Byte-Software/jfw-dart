# JFramework Dart Library

[![Pub Version](https://img.shields.io/pub/v/user_auth_sdk)](https://pub.dev/packages/user_auth_sdk)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![CI Status](https://github.com/yourusername/user_auth_sdk/actions/workflows/dart.yml/badge.svg)](https://github.com/yourusername/user_auth_sdk/actions)

A Dart SDK for seamless integration with JFramework APIs, supporting both API Key and Auth Key authentication flows.

## Features

- **Dual Authentication Methods**:
  - `APIKey` header for service-to-service auth
  - `AuthKey` header for user credential flows
- **Complete User Management**:
  - CRUD operations for users
  - Session management
  - Role-based permissions
- **Token Management**:
  - Automatic token storage
  - Secure credential handling
  - Token refresh flow

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  jfw_dart: ^1.0.0
```

## Usage

### 1. Auth Key Authentication
``` dart
final authProvider = AuthKeyProvider(null);

 final client = JfwClient(
    brandUrl: 'YOUR_BRAND_URL',
    authProvider: authProvider,
  );
```

### 2. Username/Password Authentication
``` dart

final authService = AuthService(client);

AuthenticateRequest request = AuthenticateRequest(
  username: 'user_username', // Replace with user's username
  password: 'user_password', // Replace with user's password
);

// Login with credentials
final authResponse = await authService.loginWithCredentials(request);

// If the login is successful, the response will contain the auth key
client.updateAuthProvider(AuthKeyProvider(response.authKey));

print('Login successful! Auth Key: ${response.authKey}');


```

### 3. Making Authenticated Requests
``` dart
// Subsequent requests will automatically include the Auth-Key header
final userService = UserService(client);
final user = await userService.getCurrentUser();

print('Current user: id=${user.id}, email=${user.emailAddress}, username=${user.username}');
```

## Contributing
1. Fork the repository
2. Create a feature branch (git checkout -b feature/AmazingFeature)
3. Commit your changes (git commit -m 'Add amazing feature')
4. Push to the branch (git push origin feature/AmazingFeature)
5. Open a Pull Request