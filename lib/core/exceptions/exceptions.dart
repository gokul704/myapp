import 'models/exception.model.dart';

class NoInternetException extends CustomException {
  NoInternetException({CustomException? ex}) : super(ex: ex);
}

class ServerException extends CustomException {
  ServerException({CustomException? ex}) : super(ex: ex);
}

class UnAuthorizedException extends CustomException {
  UnAuthorizedException({CustomException? ex}) : super(ex: ex);
}

class BadRequestException extends CustomException {
  BadRequestException({CustomException? ex}) : super(ex: ex);
}

class ForbiddenException extends CustomException {
  ForbiddenException({CustomException? ex}) : super(ex: ex);
}

class UserNotFoundException extends CustomException {
  UserNotFoundException({CustomException? ex}) : super(ex: ex);
}

class TimedOutException extends CustomException {
  TimedOutException({CustomException? ex}) : super(ex: ex);
}
