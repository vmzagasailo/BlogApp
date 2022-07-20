class AuthState {
  final bool isAuthorized;
  final bool isLoading;
  final bool signInMode;
  final String error;

  const AuthState({
    this.isAuthorized = false,
    this.isLoading = false,
    this.signInMode = false,
    this.error = '',
  });

  AuthState copyWith({
    bool? isAuthorized,
    bool? isLoading,
    bool? signInMode,
    String? error,
  }) {
    return AuthState(
      isAuthorized: isAuthorized ?? this.isAuthorized,
      isLoading: isLoading ?? this.isLoading,
      signInMode: signInMode ?? this.signInMode,
      error: error ?? this.error,
    );
  }
}
