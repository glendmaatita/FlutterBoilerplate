import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:my_flutter/domain/entities/user.dart';
import 'package:my_flutter/domain/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetUsers extends UseCase<List<User>, void> {
  UserRepository _repository;
  
  GetUsers(this._repository);

  @override
  Future<Observable<List<User>>> buildUseCaseObservable(void ignore) async {
    final StreamController<List<User>> _controller = StreamController();

    try {
      List<User> users = await _repository.getAll();
      _controller.add(users);
      logger.finest('GetUsers successfully executed');
      _controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetUsers unsuccessfully executed');
      _controller.addError(e);
    }
    return Observable(_controller.stream);
  }
}