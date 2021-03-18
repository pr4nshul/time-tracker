import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker1/app/landing_page.dart';

import 'Services/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Tracker",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(auth: Auth(),),
    );
  }
}
