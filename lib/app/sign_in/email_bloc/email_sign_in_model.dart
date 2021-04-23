enum emailSignInType { SignIn, CreateAccount }

class EmailSignInModel {
  EmailSignInModel(
      {this.currentState = emailSignInType.SignIn,
      this.email = ' ',
      this.password = ' ',
      this.isLoading = false,
      this.submitted = false});

  final emailSignInType currentState;
  final String email;
  final String password;
  final bool isLoading;
  final bool submitted;

  EmailSignInModel copyTo({
    emailSignInType currentState,
    String email,
    String password,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
        email: email ?? this.email ,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        submitted: submitted ?? this.submitted,
        currentState: currentState ?? this.currentState);
  }

}
