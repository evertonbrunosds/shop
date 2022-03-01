class HttpException implements Exception {
  final String msg;
  final int statusCode;

  HttpException({
    required this.msg,
    this.statusCode = 0,
  });

  @override
  String toString() {
    return msg;
  }
}
