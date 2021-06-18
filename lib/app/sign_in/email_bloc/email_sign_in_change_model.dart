import 'package:flutter/material.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/app/sign_in/email_bloc/email_sign_in_model.dart';

class EmailSignInChangeModel with ChangeNotifier {
  EmailSignInChangeModel(
      {@required this.auth,
      this.currentState = emailSignInType.SignIn,
      this.email = ' ',
      this.password = ' ',
      this.isLoading = false,
      this.submitted = false});

  final AuthBase auth;
  emailSignInType currentState;
  String email;
  String password;
  bool isLoading;
  bool submitted;

  void updateTo({
    emailSignInType currentState,
    String email,
    String password,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.currentState = currentState ?? this.currentState;
    notifyListeners();
  }

  Future<void> submit() async {
    updateTo(isLoading: true, submitted: true);
    try {
      if (this.currentState == emailSignInType.SignIn) {
        await auth.signInWithEmail(this.email, this.password);
      } else {
        await auth.createWithEmail(this.email, this.password);
      }
    } catch (e) {
      updateTo(isLoading: false);
      rethrow;
    }
  }

  void toggleState() {
    updateTo(
      submitted: false,
      currentState: this.currentState == emailSignInType.SignIn
          ? emailSignInType.CreateAccount
          : emailSignInType.SignIn,
      email: " ",
      password: " ",
    );
  }
}
