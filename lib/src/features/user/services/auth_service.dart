import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/types/api_response.dart';

class AuthService {
  final JfwClient _client;

  AuthService(this._client);

  /**
    * Authenticates a user with the provided credentials.
    * See docs: https://developers.jframework.io/references/api-reference/endpoints/users/authentication
    * @param request The authentication request containing the username and password.
    * @return A Future that resolves to an AuthenticateResponse containing the authentication key.
    * @throws ApiException if the authentication fails.
    * @throws NetworkException if there is a network error.
    * @throws InvalidCredentialsException if the provided credentials are invalid.
    * @throws UserNotFoundException if the user is not found.
    * @throws UserDisabledException if the user account is disabled.
    * @throws UserLockedException if the user account is locked.
    * @throws UserNotActivatedException if the user account is not activated.
    * @throws UserNotVerifiedException if the user account is not verified.
   */
  Future<AuthenticateResponse> loginWithCredentials(
    AuthenticateRequest request,
  ) async {
    final response = await _client.post(
      'api/v1/users/auth',
      AuthenticateRequest(
        username: request.username,
        password: request.password,
      ).toJson(),
      AuthenticateResponse.fromJson,
    );

    return response.data!;
  }

  // Login with magic link
  // This method sends a magic link to the provided email address.
  // It sends a POST request to the API endpoint 'api/v1/users/auth/by-email' with the email address and callback URL.
  // The response is parsed into a boolean indicating whether the magic link was sent successfully.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/authentication-by-email
  // @param emailAddress The email address to send the magic link to.
  // @param callbackUrl The URL to redirect the user to after clicking the magic link.
  // @param returnUrl The URL to redirect the user to after authentication.
  // @return A Future that resolves to a boolean indicating success or failure.
  Future<bool> loginWithMagicLink(
    String emailAddress,
    String callbackUrl,
    String returnUrl,
  ) async {
    final response = await _client.post(
      'api/v1/users/auth/by-email',
      {
        'emailAddress': emailAddress,
        'callbackUrl': callbackUrl,
        'returnUrl': returnUrl,
      },
      (json) => json['data'] as bool,
    );

    return response.data!;
  }

  // Register a new user
  // This method registers a new user with the provided userRequest.
  // It sends a POST request to the API endpoint 'api/v1/users/register' with the userRequest data.
  // The response is parsed into a string containing the user ID.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/users/register-a-new-user
  // @param userRequest The RegisterUserRequest object containing the user information.
  // @return A Future that resolves to an ApiResponse containing the user ID.
  Future<ApiResponse<String>> register(
    RegisterUserRequest userRequest,
  ) {
    return _client.post(
      'api/v1/users/register',
      userRequest.toJson(),
      (json) => json['data'] as String,
    );
  }
}
