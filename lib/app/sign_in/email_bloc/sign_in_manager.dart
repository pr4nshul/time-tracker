import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_tracker1/Services/auth.dart';

class SignInManager {
  SignInManager({@required this.auth,@required this.isLoading});

  final AuthBase auth;
  final ValueNotifier<bool> isLoading;


  Future<UserUid> signIn(Future<UserUid> Function() signInMethod) async {
    try {
      isLoading.value=true;
      return await signInMethod();
    } catch(e){
      isLoading.value=false;
      rethrow;
    }
  }

  Future<UserUid> signInGoogle() async => await signIn(auth.signInGoogle);

  Future<UserUid> signInAnonymously() async => await signIn(auth.signInAnonymously);
}
