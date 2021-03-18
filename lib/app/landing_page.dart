import 'package:flutter/material.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/app/home_page.dart';
import 'package:time_tracker1/app/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserUid>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserUid user = snapshot.data;
          return user == null
              ? SignInPage(
                  auth: auth,
                )
              : HomePage(
                  auth: auth,
                );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      stream: auth.onAuthStateChanged,
    );
  }
}
