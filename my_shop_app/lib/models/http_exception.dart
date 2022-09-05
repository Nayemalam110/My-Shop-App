class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    if (message == 'EMAIL_EXISTS') {
      print('Http Exception occured');
    }

    return message;
  }
}
