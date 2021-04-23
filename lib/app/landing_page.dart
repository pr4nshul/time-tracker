import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/app/home_page.dart';
import 'package:time_tracker1/app/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context,listen: false);
    return StreamBuilder<UserUid>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserUid user = snapshot.data;
          return user == null
              ? SignInPage.create(context)
              : HomePage();
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
