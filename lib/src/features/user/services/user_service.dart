import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/types/pagination.dart';

class UserService {
  final JfwClient _client;

  UserService(this._client);

  // Get the current user
  // This method retrieves the current user from the API.
  // It sends a GET request to the API endpoint 'api/v1/users/me'.
  // The response is parsed into a User object and returned.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/gets-the-current-user-logged-in
  // @return A Future that resolves to a User object.
  Future<User> getCurrentUser() async {
    final apiResponse =
        await _client.get<User>(UserRoutes.getCurrentUser(), User.fromJson);
    return apiResponse.data!;
  }

  // Get user by ID
  // This method retrieves a user by their ID from the API.
  // It sends a GET request to the API endpoint 'api/v1/users/{userId}'.
  // The response is parsed into a User object and returned.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/get-a-user
  // @param userId The ID of the user to be retrieved.
  // @return A Future that resolves to a User object.
  Future<User> getUserById(String userId) async {
    final apiResponse =
        await _client.get<User>(UserRoutes.getUserById(userId), User.fromJson);
    return apiResponse.data!;
  }

  // Get a list of users based on the provided query parameters
  // This method retrieves a paginated list of users from the API.
  // It accepts a UsersQueryRequest object containing the query parameters.
  // The response is parsed into a Pagination<User> object.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/get-users
  // @param query The UsersQueryRequest object containing the query parameters.
  // @return A Future that resolves to a Pagination<User> object containing the list of users.
  Future<Pagination<User>> getUsers({
    required UsersQueryRequest query,
  }) async {
    final queryString = query.toQueryString();
    final apiResponse = await _client.get<Pagination<User>>(
      UserRoutes.getUsers(queryString),
      (json) => Pagination<User>.fromJson(json, User.fromJson),
    );

    return apiResponse.data!;
  }

  // Update user information
  // This method updates the user information based on the provided userId and payloadRequest.
  // It sends a PUT request to the API endpoint 'api/v1/users/{userId}' with the payloadRequest data.
  // The response is parsed into a User object and returned.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/update-a-user
  // @param userId The ID of the user to be updated.
  // @param payloadRequest The request object containing the updated user information.
  // @return A Future that resolves to the updated User object.
  Future<User> update(
    String userId,
    UserUpdateRequest payloadRequest,
  ) async {
    final apiResponse = await _client.put<User>(
      UserRoutes.updateUser(userId),
      payloadRequest.toJson(),
      User.fromJson,
    );

    return apiResponse.data!;
  }

  // Change user password
  // This method changes the password of a user based on the provided userId and payloadRequest.
  // It sends a PUT request to the API endpoint 'api/v1/users/{userId}/change-password' with the payloadRequest data.
  // The response is parsed into a boolean indicating success or failure.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/change-password
  // @param userId The ID of the user whose password is to be changed.
  // @param payloadRequest The request object containing the new password information.
  // @return A Future that resolves to a boolean indicating success or failure.
  Future<bool> changePassword(ChangePasswordRequest payloadRequest) {
    return _client
        .put<bool>(
          UserRoutes.changePassword(),
          payloadRequest.toJson(),
          (json) => json['data'] as bool,
        )
        .then((value) => value.data!);
  }

  // Forgot password
  // This method sends a password reset link to the user's email address.
  // It sends a POST request to the API endpoint 'api/v1/users/forgot-password' with the email address and reset password link.
  // The response is parsed into a boolean indicating success or failure.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/forgot-password
  // @param emailAddress The email address of the user to receive the password reset link.
  // @param resetPasswordLink The link to be sent to the user's email address for password reset.
  // @return A Future that resolves to a boolean indicating success or failure.
  Future<bool> forgotPassword(String emailAddress, String resetPasswordLink) {
    return _client
        .post<bool>(
          UserRoutes.forgotPassword(),
          {
            'emailAddress': emailAddress,
            'resetPasswordLink': resetPasswordLink,
          },
          (json) => json['data'] as bool,
        )
        .then((value) => value.data!);
  }

  // Reset password
  // This method resets the user's password based on the provided email address, token, and new password.
  // It sends a POST request to the API endpoint 'api/v1/users/reset-password' with the email address, token, and new password.
  // The response is parsed into a boolean indicating success or failure.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/reset-password
  // @param emailAddress The email address of the user whose password is to be reset.
  // @param token The token sent to the user's email address for password reset.
  // @param newPassword The new password to be set for the user.
  // @return A Future that resolves to a boolean indicating success or failure.
  Future<bool> resetPassword(
    String emailAddress,
    String token,
    String newPassword,
  ) {
    return _client
        .post<bool>(
          UserRoutes.resetPassword(),
          {
            'emailAddress': emailAddress,
            'token': token,
            'newPassword': newPassword,
          },
          (json) => json['data'] as bool,
        )
        .then((value) => value.data!);
  }

  // Get devices by user ID
  // This method retrieves a list of devices associated with a user based on the provided userId.
  // It sends a GET request to the API endpoint 'api/v1/users/{userId}/devices'.
  // The response is parsed into a list of UserDevice objects.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/get-devices-from-a-user
  // @param userId The ID of the user whose devices are to be retrieved.
  // @return A Future that resolves to a list of UserDevice objects.
  Future<List<UserDevice>> getDevicesByUserId(String userId) async {
    final apiResponse = await _client.get<List<UserDevice>>(
        UserRoutes.getDevicesByUserId(userId),
        (json) => (json as List<dynamic>)
            .map((e) => UserDevice.fromJson(e))
            .toList());
    return apiResponse.data ?? [];
  }

  // Remove a device from a user
  // This method removes a device from a user based on the provided userId and deviceId.
  // It sends a DELETE request to the API endpoint 'api/v1/users/{userId}/devices/{deviceId}'.
  // The response is parsed into a boolean indicating success or failure.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/remove-a-device-from-a-user
  // @param userId The ID of the user from whom the device is to be removed.
  // @param deviceId The ID of the device to be removed.
  // @return A Future that resolves to a boolean indicating success or failure.
  Future<bool> removeDeviceFromUser(
    String userId,
    String deviceId,
  ) async {
    final apiResponse = await _client.delete<bool>(
      UserRoutes.removeDevice(userId, deviceId),
      (json) => json['data'] as bool,
    );
    return apiResponse.data!;
  }

  // Add a device to a user
  // This method adds a device to a user based on the provided userId, deviceId, token, session, tags, and status.
  // It sends a POST request to the API endpoint 'api/v1/users/{userId}/devices/{deviceId}' with the device details.
  // The response is parsed into a boolean indicating success or failure.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/add-a-device-to-a-user
  // @param userId The ID of the user to whom the device is to be added.
  // @param deviceId The ID of the device to be added.
  // @param token The token associated with the device, this token is used to identify the device and push notifications on firebase service.
  // @param session The session ID associated with the device.
  // @param tags The tags associated with the device.
  // @param status The status of the device.
  // @return A Future that resolves to a boolean indicating success or failure.
  Future<bool> addDeviceToUser(
    String userId,
    String deviceId,
    String token,
    String session,
    String tags,
    UserDeviceStatus status,
  ) async {
    final apiResponse = await _client.post<bool>(
      UserRoutes.addDevice(userId, deviceId),
      {
        'token': token,
        'session': session,
        'tags': tags,
        'status': status.toString(),
      },
      (json) => json['data'] as bool,
    );
    return apiResponse.data!;
  }
}
