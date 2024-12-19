import 'package:flutter/material.dart';
import 'package:storage/app/core/result.dart';

typedef CommandActionWithoutArguments<T> = Future<Result<T>> Function();
typedef CommandActionWithArgument<T, A> = Future<Result<T>> Function(A);

abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;

  bool get running => _running;

  Result<T>? _result;

  bool get error => _result is Error;

  bool get completed => _result is Ok;

  Result? get result => _result;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandActionWithoutArguments<T> action) async {
    if (_running) return;

    _running = true;

    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;

      notifyListeners();
    }
  }
}

class CommandWithoutArguments<T> extends Command<T> {
  CommandWithoutArguments(this._action);

  final CommandActionWithoutArguments<T> _action;

  Future<void> execute() async {
    await _execute(() => _action());
  }
}

class CommandWithArguments<T, A> extends Command<T> {
  CommandWithArguments(this._action);

  final CommandActionWithArgument<T, A> _action;

  /// Executes the action with the argument.
  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
