class PasswordValidator {
  static bool validate(String password) {
    if (password.length >= 8) {
      return true;
    } else {
      return false;
    }
  }
}
