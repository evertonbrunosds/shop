enum SignState { signUp, signIn, signOut }

class SignMode {
  SignState state;

  SignMode({required this.state});

  bool get isSignUp => state == SignState.signUp;

  void toSignUp() => state = SignState.signUp;

  bool get isSignIn => state == SignState.signIn;

  void toSignIn() => state = SignState.signIn;

  bool get isSignOut => state == SignState.signOut;

  void toSignOut() => state = SignState.signOut;
}
