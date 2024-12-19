import 'package:storage/app/core/app_exception.dart';

sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;
  const factory Result.error(AppException value) = Error._;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;
}

final class Error<T> extends Result<T> {
  const Error._(this.error);

  final AppException error;

  @override
  String toString() {
    return 'Result<$T>.error($error)';
  }
}
