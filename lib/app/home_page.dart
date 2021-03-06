import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/common_widgets/alert_dialog.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final AuthBase auth = Provider.of<AuthBase>(context,listen: false);
    try {
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> _confirmSignOut(BuildContext context) async{
    final requestSignOut = await PlatformAlertDialog(
      actionText: "Logout",
      content: "Are you sure?",
      title: "Logout",
      cancelText: "Cancel",
    ).show(context);
    if(requestSignOut==true){
      _signOut(context);
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
            onPressed: () => _confirmSignOut(context),
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
