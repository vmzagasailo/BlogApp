import 'package:blog_app/middleware/blocs/auth/auth_state.dart';
import 'package:blog_app/presentation/core/auth_exeption_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(isLoading: false, isAuthorized: true));
    } catch (error) {
      print('$error');
      emit(state.copyWith(error: '$error', isLoading: false));
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(isLoading: false, isAuthorized: true));
    } catch (error) {
      print('$error');

      _handleError(error, emit);
    }
  }

  void switchAuthMode(bool signInMode) {
    emit(state.copyWith(signInMode: signInMode));
  }

  void _handleError(dynamic error, emit) {
    print(error);
    String message = ExceptionHandler.handleAuthException(error?.code);
    emit(state.copyWith(error: message, isLoading: false));
  }
}
