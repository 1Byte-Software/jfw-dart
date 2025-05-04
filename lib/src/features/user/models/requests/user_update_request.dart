class UserUpdateRequest {
  final String username;
  final String emailAddress;
  final String nickname;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? website;
  final String? bio;
  final String languageCode;
  final String? avatar;

  UserUpdateRequest(
      {required this.username,
      required this.emailAddress,
      required this.nickname,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.website,
      this.bio,
      required this.languageCode,
      this.avatar});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'emailAddress': emailAddress,
      'nickname': nickname,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'website': website,
      'bio': bio,
      'languageCode': languageCode,
      'avatar': avatar
    };
  }
}
