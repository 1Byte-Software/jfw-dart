class AuthenticateRequest {
  final String username;
  final String password;

  AuthenticateRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
