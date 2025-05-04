class PaginationRequest {
  int? pageNumber;
  int? pageSize;

  PaginationRequest({
    this.pageNumber,
    this.pageSize,
  });

  Map<String, String> toQueryParam() {
    final queryParameters = {
      if (pageNumber != null) 'pageNumber': pageNumber.toString(),
      if (pageSize != null) 'pageSize': pageSize.toString(),
    };
    return queryParameters;
  }
}
