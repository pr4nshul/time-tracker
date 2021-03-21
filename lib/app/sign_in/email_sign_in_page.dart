import 'package:flutter/material.dart';
import 'package:time_tracker1/Services/auth.dart';
import 'package:time_tracker1/common_widgets/alert_dialog.dart';

class EmailSignIn extends StatefulWidget {
  EmailSignIn({@required this.auth});

  final AuthBase auth;

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

enum emailSignIn { SignIn, CreateAccount }

class _EmailSignInState extends State<EmailSignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //FocusNode _emailNode = FocusNode(); FocusNode _passwordNode = FocusNode();
  emailSignIn _currentState = emailSignIn.SignIn;

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  bool _isLoading = false;
  bool _submitted = false;

  void _submit() async {
    setState(() {
      _isLoading = true;
      _submitted = true;
    });
    try {
      if (_currentState == emailSignIn.SignIn) {
        await widget.auth.signInWithEmail(_email, _password);
      } else {
        await widget.auth.createWithEmail(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      PlatformAlertDialog(
        title: "Sign In Failed!",
        content: e.toString(),
        actionText: 'OK',
      ).show(context);
      //print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleState() {
    setState(
      () {
        _currentState = _currentState == emailSignIn.SignIn
            ? emailSignIn.CreateAccount
            : emailSignIn.SignIn;
        _emailController.clear();
        _passwordController.clear();
        _submitted = false;
      },
    );
  }

  List<Widget> _buildContent() {
    String _primaryButton =
        _currentState == emailSignIn.SignIn ? "Sign In" : "Create an account";
    String _secondaryButton = _currentState == emailSignIn.SignIn
        ? "Do not have an account? Register here"
        : "Already have an account? Sign in here";
    bool _submitEnable =
        _email.isNotEmpty && _password.isNotEmpty && !_isLoading;
    return [
      TextFormField(
        controller: _emailController,
        //focusNode: _emailNode,
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "test@test.com",
          errorText:
              _email.isEmpty && _submitted ? "Email can't be empty" : null,
        ),
        onChanged: (email) => _updateState(),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        enabled: !_isLoading,
      ),
      SizedBox(height: 10),
      TextFormField(
        //focusNode: _passwordNode,
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: _password.isEmpty && _submitted
              ? "Password can't be empty"
              : null,
        ),
        onChanged: (password) => _updateState(),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onEditingComplete: _submit,
        enabled: !_isLoading,
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
        onPressed: _isLoading ? null : _toggleState,
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
    String _email = _emailController.text;
    String _password = _passwordController.text;
    return Padding(
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
    );
  }

  _updateState() {
    setState(() {});
  }
}
