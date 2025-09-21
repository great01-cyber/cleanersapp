import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninState {
  final String email;
  final String password;
  final String displayName;

  SigninState({
    this.email = "",
    this.password = "",
    this.displayName = "",
  });

  SigninState copyWith(
      {String? displayName,
      String? email,
      String? password,
      String? rePassword}) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
        displayName: displayName ?? this.displayName);
  }
}
