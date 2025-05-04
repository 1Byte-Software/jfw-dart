import 'package:jfw_dart/jfw.dart';
import 'package:jfw_dart/src/types/pagination.dart';

class CdnService {
  final JfwClient _client;

  CdnService(this._client);

  // Upload a file to the CDN
  // This method uploads a file to the CDN.
  // It sends a POST request to the API endpoint 'api/v1/cdn/upload'.
  // The response is parsed into a CdnUploadResponse object and returned.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/cdn/upload-file
  // @param file The file to be uploaded.
  // @return A Future that resolves to a CdnUploadResponse object containing the upload result.
  Future<CdnUploadResponse> uploadFile(UploadCdnRequest uploadCdnRequest) async {
    final apiResponse = await _client.postMultipartRequest<CdnUploadResponse>(
      CdnRoutes.uploadFile(),
      uploadCdnRequest.toFormFields(),
      [await uploadCdnRequest.toMultipartFile()],
      CdnUploadResponse.fromJson,
    );
    return apiResponse.data!;
  }

  // Get a list of files from the CDN
  // This method retrieves a paginated list of files from the CDN.
  // It accepts a CdnQueryRequest object containing the query parameters.
  // The response is parsed into a Pagination<Cdn> object.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/cdn/get-files-cdn
  // @param query The CdnQueryRequest object containing the query parameters.
  // @return A Future that resolves to a Pagination<Cdn> object containing the list of files.
  Future<Pagination<Cdn>> getFiles({
    required CdnQueryRequest query,
  }) async {
    final queryString = query.toQueryString();
    final apiResponse = await _client.get<Pagination<Cdn>>(
      CdnRoutes.getFilesCdn(queryString),
      (json) => Pagination<Cdn>.fromJson(json, Cdn.fromJson),
    );

    return apiResponse.data!;
  }

  // Get a file from the CDN by its ID
  // This method retrieves a file from the CDN by its ID.
  // It sends a GET request to the API endpoint 'api/cdn/{fileId}'.
  // The response is parsed into a Cdn object and returned.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/cdn/get-a-file-cdn
  // @param fileId The ID of the file to be retrieved.
  // @return A Future that resolves to a Cdn object containing the file information.
  Future<Cdn> getById(
    String fileId,
  ) async {
    final apiResponse = await _client.get<Cdn>(
      CdnRoutes.getById(fileId),
      Cdn.fromJson,
    );
    return apiResponse.data!;
  }

  // Delete a file from the CDN by its ID
  // This method deletes a file from the CDN by its ID.
  // It sends a DELETE request to the API endpoint 'api/cdn/{fileId}'.
  // The response is parsed into a boolean indicating success or failure.
  // See docs: https://developers.jframework.io/references/api-reference/endpoints/cdn/delete-a-file-cdn
  // @param fileId The ID of the file to be deleted.
  // @return A Future that resolves to a boolean indicating success or failure.
  Future<bool> deleteById(
    String fileId,
  ) {
    return _client
        .delete<bool>(
          CdnRoutes.getById(fileId),
          (json) => json['data'] as bool,
        )
        .then((value) => value.data!);
  }
}
