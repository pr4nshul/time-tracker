import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/app/sign_in/email_bloc/email_sign_page_bloc.dart';
import 'package:time_tracker1/app/sign_in/email_bloc/email_sign_page_change_model.dart';
import 'package:time_tracker1/app/sign_in/email_bloc/sign_in_manager.dart';
import 'package:time_tracker1/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker1/app/sign_in/email_bloc/sign_in_manager.dart';
import 'package:time_tracker1/app/sign_in/socialSignInButton.dart';
import 'package:time_tracker1/common_widgets/platform_exception_alert_dialog.dart';
import 'customSignInButton.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.manager,@required this.isLoading});

  final SignInManager manager;
  final bool isLoading;
  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (context) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => SignInPage(manager: manager,isLoading: isLoading.value,),
          ),
        ),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: "Sign In Failed!",
        exception: e,
      ).show(context);
    }
  }

  Future<void> _signInGoogle(BuildContext context) async {
    try {
      await manager.signInGoogle();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: "Sign In Failed!",
        exception: e,
      ).show(context);
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
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
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
                    onPressed:
                        isLoading ? null : () => _signInGoogle(context),
                    color: Colors.white,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // SocialSignInButton(
                  //   assetName: "images/facebook-logo.png",
                  //   text: "Sign in with Facebook(disabled)",
                  //   borderRadius: 8.0,
                  //   textColor: Colors.white,
                  //   onPressed: null,
                  //   color: Colors.blue,
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomSignInButton(
                    text: "Sign in with Email",
                    borderRadius: 8.0,
                    textColor: Colors.white,
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      title: Text("Sign In"),
                                      centerTitle: true,
                                    ),
                                    body: SingleChildScrollView(
                                      child: Center(
                                        child:
                                            EmailSignInWithChangeModel.create(context),
                                      ),
                                    ),
                                  );
                                },
                                fullscreenDialog: true,
                              ),
                            );
                          },
                    color: Colors.teal[600],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Text(
                      "or",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  CustomSignInButton(
                    text: "Go anonymous",
                    borderRadius: 8.0,
                    textColor: Colors.white,
                    onPressed: isLoading
                        ? null
                        : () => _signInAnonymously(context),
                    color: Colors.purple[300],
                  ),
                ],
              ),
            )
    );
  }
}
