import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<UserUid> get onAuthStateChanged;
  Future<void> signOut();
  Future<UserUid> signInAnonymously();
  Future<UserUid> signInWithEmail(String email,String password);
  Future<UserUid> createWithEmail(String email,String password);
  UserUid currentUser();
  Future<UserUid> signInGoogle();
}

class UserUid {
  UserUid({@required this.userUid});

  final String userUid;
}

class Auth implements AuthBase {
  UserUid returnUser(User user) {
    if (user == null) {
      return null;
    }
    return UserUid(userUid: user.uid);
  }

  @override
  Stream<UserUid> get onAuthStateChanged {
    return FirebaseAuth.instance.authStateChanges().map(returnUser);
  }

  @override
  Future<UserUid> signInAnonymously() async {
    try {
      final authResult = await FirebaseAuth.instance.signInAnonymously();
      return returnUser(authResult.user);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
  @override
  Future<UserUid> signInGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return returnUser(authResult.user);
      } else {
        throw PlatformException(
          code: "ERROR_MISSING_GOOGLE_TOKEN",
          message: "Missing Google Credentials",
        );
      }
    } else {
      throw PlatformException(
        code: 'ABORTED_BY_USER',
        message: "Sign in aborted!",
      );
    }
  }
  @override
  Future<UserUid> signInWithEmail(String email,String password) async{
    final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,);
    return returnUser(authResult.user);
  }
  @override
  Future<UserUid> createWithEmail(String email,String password) async{
    final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return returnUser(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  UserUid currentUser() {
    User user = FirebaseAuth.instance.currentUser;
    return returnUser(user);
  }
}
