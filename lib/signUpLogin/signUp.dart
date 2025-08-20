import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uos/signUpLogin/signUpDetails.dart';

part 'signUp.g.dart';

@riverpod
class signUp extends _$signUp {
  @override
  SignUpDetails build() {
    return SignUpDetails();
  }

  void onChangedUsername(String name) {
    state = state.copyWith(userName: name);
  }

  void onChangedEmail(String email) {
    state = state.copyWith(email: email);
  }

  void onChangedPassword(String password) {
    state = state.copyWith(password: password);
  }

  void onChangedRePassword(String rePassword) {
    state = state.copyWith(rePassword: rePassword);
  }
}