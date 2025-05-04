class RegisterUserRequest {
  final String username;
  final String emailAddress;
  String? phoneNumber;
  final String password;
  String? firstName;
  String? lastName;
  String? referralCode;
  String? timezoneId;

  RegisterUserRequest(
      {required this.username,
      required this.emailAddress,
      this.phoneNumber,
      required this.password,
      this.firstName,
      this.lastName,
      this.referralCode,
      this.timezoneId});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'referralCode': referralCode,
      'timezoneId': timezoneId
    };
  }
}
