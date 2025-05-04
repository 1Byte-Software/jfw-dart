class AuthenticateResponse {
  final String id;
  final String username;
  final String emaillAddress;
  final String authKey;

  AuthenticateResponse(
      {required this.id,
      required this.username,
      required this.emaillAddress,
      required this.authKey});

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponse(
        id: json['id'] as String,
        username: json['username'] as String,
        emaillAddress: json['emailAddress'] as String,
        authKey: json['authKey'] as String);
  }
}
