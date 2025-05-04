class BaseUser {
  final String id;
  final String code;
  final String avatar;
  final String packageId;
  final String? nickname;
  final String emailAddress;
  final List<String>? roles;

  BaseUser({
    required this.id,
    required this.code,
    required this.avatar,
    required this.packageId,
    this.nickname,
    required this.emailAddress,
    this.roles,
  });

  factory BaseUser.fromJson(Map<String, dynamic> json) {
    return BaseUser(
      id: json['id'] as String,
      code: json['code'] as String,
      avatar: json['avatar'] as String,
      packageId: json['packageId'] as String,
      nickname: json['nickname'] as String?,
      emailAddress: json['emailAddress'] as String,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }
}
