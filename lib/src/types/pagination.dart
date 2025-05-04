class Pagination<T> {
  final int pageNumber;
  final int pageSize;
  final int totalItems;
  final List<T> items;

  Pagination({
    required this.pageNumber,
    required this.pageSize,
    required this.totalItems,
    required this.items,
  });

  factory Pagination.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return Pagination<T>(
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
      totalItems: json['totalItems'] as int,
      items: (json['items'] as List<dynamic>)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(
            growable: false,
          ),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalItems': totalItems,
      'items': items.map(toJsonT).toList(),
    };
  }
}
