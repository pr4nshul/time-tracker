import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/app/sign_in/email_bloc/email_sign_in_model.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});

  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelController => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  void updateWith(
      {String email,
      String password,
      bool submitted,
      bool isLoading,
      emailSignInType currentState}) {
    _model = _model.copyTo(
      currentState: currentState,
      email: email,
      submitted: submitted,
      isLoading: isLoading,
      password: password,
    );
    _modelController.add(_model);
  }

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (_model.currentState == emailSignInType.SignIn) {
        await auth.signInWithEmail(_model.email, _model.password);
      } else {
        await auth.createWithEmail(_model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
  void toggleState(){
    updateWith(
      submitted: false,
      currentState: _model.currentState == emailSignInType.SignIn
          ? emailSignInType.CreateAccount
          : emailSignInType.SignIn,
      email: " ",
      password: " ",
    );
  }
}
