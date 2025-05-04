import 'package:jfw_dart/src/models/requests/pagination_request.dart';

class UsersQueryRequest extends PaginationRequest {
  String? roleId;
  String? code;
  String? username;
  String? firstName;
  String? lastName;
  String? keywords;
  String? status;

  UsersQueryRequest({
    this.roleId,
    this.code,
    this.username,
    this.firstName,
    this.lastName,
    this.keywords,
    this.status,
    int? pageNumber,
    int? pageSize,
  }) : super(pageNumber: pageNumber, pageSize: pageSize);

  String toQueryString() {
    final queryParameters = {
      if (roleId != null) 'roleId': roleId,
      if (code != null) 'code': code,
      if (username != null) 'username': username,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (keywords != null) 'keywords': keywords,
      if (status != null) 'status': status,
      ...super.toQueryParam(),
    };

    return queryParameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }
}
