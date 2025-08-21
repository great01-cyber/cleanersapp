import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uosc/Supervisor/signInState.dart';

class SignInNotifier extends StateNotifier<SigninState> {
  SignInNotifier() : super(SigninState());

  void onChangedEmail(String email) {
    state = state.copyWith(email: email);
  }

  void onChangedPassword(String password) {
    state = state.copyWith(password: password);
  }
}

final signInNotifierProvider =
    StateNotifierProvider<SignInNotifier, SigninState>(
        (ref) => SignInNotifier());
