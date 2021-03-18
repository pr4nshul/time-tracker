import 'package:flutter/material.dart';
import 'package:time_tracker1/Services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.auth});

  final AuthBase auth;
  Future<void> _signOut() async {
    try {
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
        actions: [
          TextButton(
            onPressed: _signOut,
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
