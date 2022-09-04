class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    if (message == 'EMAIL_EXISTS') {
      print('object adsffds');
    }

    return message;
  }
}
