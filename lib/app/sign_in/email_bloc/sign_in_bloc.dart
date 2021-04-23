import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_tracker1/Services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});

  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingController {
    return _isLoadingController.stream;
  }

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) {
    _isLoadingController.add(isLoading);
  }

  Future<UserUid> signIn(Future<UserUid> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch(e){
      _setIsLoading(false);
      rethrow;
    }
  }

  Future<UserUid> signInGoogle() async => await signIn(auth.signInGoogle);

  Future<UserUid> signInAnonymously() async => await signIn(auth.signInAnonymously);
}
