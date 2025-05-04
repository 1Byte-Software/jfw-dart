import 'package:jfw_dart/src/features/user/types/base_user.dart';

class User extends BaseUser {
  final String brandId;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? website;
  final String? bio;
  final bool isEmailAddressVerified;
  final bool isUserVerified;
  final String referralCode;
  final String status;
  final String? languageCode;
  final DateTime expiryDate;

  User({
    required String id,
    required String code,
    required String avatar,
    required String packageId,
    String? nickname,
    required String emailAddress,
    List<String>? roles,
    required this.brandId,
    required this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.website,
    this.bio,
    required this.isEmailAddressVerified,
    required this.isUserVerified,
    required this.referralCode,
    required this.status,
    this.languageCode,
    required this.expiryDate,
  }) : super(
          id: id,
          code: code,
          avatar: avatar,
          packageId: packageId,
          nickname: nickname,
          emailAddress: emailAddress,
          roles: roles,
        );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      code: json['code'] as String,
      avatar: json['avatar'] as String,
      packageId: json['packageId'] as String,
      nickname: json['nickname'] as String?,
      emailAddress: json['emailAddress'] as String,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      brandId: json['brandId'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      website: json['website'] as String?,
      bio: json['bio'] as String?,
      isEmailAddressVerified: json['isEmailAddressVerified'] as bool,
      isUserVerified: json['isUserVerified'] as bool,
      referralCode: json['referralCode'] as String,
      status: json['status'] as String,
      languageCode: json['languageCode'] as String?,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
    );
  }
}
