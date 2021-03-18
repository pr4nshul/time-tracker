import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/app/sign_in/socialSignInButton.dart';
import 'customSignInButton.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.onSignIn, @required this.auth});

  final Function(UserUid) onSignIn;
  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      final authResult = await auth.signInAnonymously();
      onSignIn(authResult);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Time Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2.0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SocialSignInButton(
              assetName: "images/google-logo.png",
              text: "Sign in with Google",
              borderRadius: 8.0,
              textColor: Colors.black87,
              onPressed: () {},
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            SocialSignInButton(
              assetName: "images/facebook-logo.png",
              text: "Sign in with Facebook",
              borderRadius: 8.0,
              textColor: Colors.white,
              onPressed: () {},
              color: Colors.blue,
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomSignInButton(
              text: "Sign in with Email",
              borderRadius: 8.0,
              textColor: Colors.white,
              onPressed: () {},
              color: Colors.teal[600],
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: Text(
                "or",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            CustomSignInButton(
              text: "Go anonymous",
              borderRadius: 8.0,
              textColor: Colors.white,
              onPressed: _signInAnonymously,
              color: Colors.purple[300],
            ),
          ],
        ),
      ),
    );
  }
}
