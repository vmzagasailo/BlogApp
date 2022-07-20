class ExceptionHandler {
  static String handleAuthException(String? errorCode) {
    switch (errorCode) {
      case 'account-exists-with-different-credential':
      case 'email-already-in-use':
        return 'This email is already is use';
      case 'wrong-password':
        return 'Wrong password';
      case 'too-many-requests':
        return 'Too many requests';
      case 'user-not-found':
        return 'User not found';
      case 'operation-not-allowed':
        return 'Operation is not allowed';
      case 'user-disabled':
        return 'Your account was disabled';
      case 'invalid-email':
        return 'You entered invalid email address';
      case 'invalid-credential':
        return 'Invalid credentials';
      case 'weak-password':
        return 'Weak password';
      default:
        if (errorCode != null) {
          return 'Authentication error $errorCode';
        } else {
          return 'Authentication error';
        }
    }
  }
}
