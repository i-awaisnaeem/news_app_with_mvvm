
// Parent Class
class AppExceptions implements Exception{

  //Properties
  final String? message;
  final String? prefix;

//Constructor
AppExceptions({this.message, this.prefix});

// Override default toString() method
@override
  String toString(){
  return '$prefix$message';
  }
}

// Child Class
class FetchDataException extends AppExceptions{

  //initializes the parent class with a default prefix of "Error During Communication".
  // The constructor accepts an optional 'message' parameter,
  // allowing for additional customization of the error message.
  FetchDataException([String? message]) : super(message: message, prefix: 'Error During Communicaton');
}
// Child Class
class BadRequestException extends AppExceptions{
  BadRequestException([String? message]) : super(message: message, prefix: 'Invalid Request');
}
// Child Class
class UnautorisedException extends AppExceptions{
  UnautorisedException([String? message]) : super(message: message,prefix: 'Unauthorized Request');
}
// Child Class
class InvalidInputException extends AppExceptions{
  InvalidInputException([String? message]) : super(message: message, prefix: 'Invalid Request');
}
