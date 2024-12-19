import 'package:storage/app/core/app_exception.dart';

class AppHttpException extends AppException {
  const AppHttpException({
    required super.message,
    required super.stackTrace,
  });
}
