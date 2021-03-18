import 'package:flutter/material.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/app/home_page.dart';
import 'package:time_tracker1/app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});

  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  UserUid _user;

  @override
  void initState() {
    super.initState();
    UserUid user = widget.auth.currentUser();
    _userUpdate(user);
  }

  void _userUpdate(UserUid user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? SignInPage(
            auth: widget.auth,
            onSignIn: _userUpdate,
          )
        : HomePage(
            auth: widget.auth,
            onSignOut: () => _userUpdate(null),
          );
  }
}
