class AppException implements Exception {
  final String message;
  final String? prefix;

  AppException([this.message = "An error occurred", this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class NetworkException extends AppException {
  NetworkException([String message = 'No Internet Available '])
      : super(message, 'Internet Error');
}

class TimeOutException extends AppException {
  TimeOutException([String message = ' Request Time Out '])
      : super(message, ' Timeout Error ');
}

class BedRequestException extends AppException {
  BedRequestException([String message = ' Invalid Request '])
      : super(message, 'Bad request Error');
}

class InvalidResponceException extends AppException {
  InvalidResponceException([String message = ' Invalid Responce '])
      : super(message, 'Responce Error');
}

class OtherException extends AppException {
  OtherException([String message = ' Something Went Wrong '])
      : super(message, 'Error');
}
