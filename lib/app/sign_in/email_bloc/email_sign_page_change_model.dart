import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/app/sign_in/email_bloc/email_sign_in_bloc.dart';
import 'package:time_tracker1/app/sign_in/email_bloc/email_sign_in_model.dart';
import 'package:time_tracker1/common_widgets/alert_dialog.dart';

import 'email_sign_in_change_model.dart';

class EmailSignInWithChangeModel extends StatefulWidget {
  EmailSignInWithChangeModel({@required this.model});

  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) => EmailSignInWithChangeModel(
          model: model,
        ),
      ),
    );
  }

  @override
  _EmailSignInWithChangeModelState createState() => _EmailSignInWithChangeModelState();
}

class _EmailSignInWithChangeModelState extends State<EmailSignInWithChangeModel> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;
  EmailSignInChangeModel get model => widget.model;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await model.submit();
      Navigator.of(context).pop();
    } catch (e) {
      PlatformAlertDialog(
        title: "Sign In Failed!",
        content: e.toString(),
        actionText: 'OK',
      ).show(context);
      //print(e.toString());
    }
  }
  void changeFocus(){
    FocusScope.of(context).requestFocus(_passwordNode);
  }
  void _toggleState() {
    model.toggleState();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildContent() {
    String _primaryButton = model.currentState == emailSignInType.SignIn
        ? "Sign In"
        : "Create an account";
    String _secondaryButton = model.currentState == emailSignInType.SignIn
        ? "Do not have an account? Register here"
        : "Already have an account? Sign in here";
    bool _submitEnable =
        _email.isNotEmpty && _password.isNotEmpty && !model.isLoading;
    return [
      TextFormField(
        controller: _emailController,
        focusNode: _emailNode,
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "test@test.com",
          errorText:
              _email.isEmpty && model.submitted ? "Email can't be empty" : null,
        ),
        onChanged: (email) => model.updateTo(email: _email),
        autocorrect: false,
        onFieldSubmitted: (_)=> changeFocus,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        enabled: !model.isLoading,
      ),
      SizedBox(height: 10),
      TextFormField(
        focusNode: _passwordNode,
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: _password.isEmpty && model.submitted
              ? "Password can't be empty"
              : null,
        ),
        onChanged: (password) => model.updateTo(password: _password),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onEditingComplete: _submit,
        enabled: !model.isLoading,
      ),
      SizedBox(height: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text(
            _primaryButton,
            style: TextStyle(fontSize: 22),
          ),
        ),
        onPressed: _submitEnable ? _submit : null,
      ),
      TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: model.isLoading ? null : () => _toggleState(),
        child: Text(
          _secondaryButton,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // String _email = _emailController.text;
    // String _password = _passwordController.text;

    return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: _buildContent(),
                  ),
                ),
              ),
            ),
          );
  }
}
