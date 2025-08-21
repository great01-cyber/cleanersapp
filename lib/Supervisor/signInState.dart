import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninState {
  final String email;
  final String password;

  SigninState({
    this.email = "",
    this.password = "",
  });

  SigninState copyWith(
      {String? userName, String? email, String? password, String? rePassword}) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
