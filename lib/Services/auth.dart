
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthBase{
  Future<void> signOut();
  Future<UserUid> signInAnonymously();
  UserUid currentUser();
}
class UserUid{
  UserUid({ @required this.userUid});
  final String userUid;
}
class Auth implements AuthBase{
  UserUid returnUser(User user){
    if(user==null){
      return null;
    }
    return UserUid(userUid: user.uid);
  }
  @override
  Future<UserUid> signInAnonymously() async {
    try {
      final authResult = await FirebaseAuth.instance.signInAnonymously();
      return returnUser(authResult.user);
    }catch(e){
      print(e.toString());
    }
    return null;
  }
  @override
  Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
  }
  @override
  UserUid currentUser() {
    User user =FirebaseAuth.instance.currentUser;
    return returnUser(user);
  }
}