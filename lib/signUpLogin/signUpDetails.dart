class SignUpDetails {
  final String userName;
  final String email;
  final String password;
  final String rePassword;

  SignUpDetails({
    this.userName = "",
    this.email = "",
    this.password = "",
    this.rePassword = "",
  });

  SignUpDetails copyWith({
    String? userName,
    String? email,
    String? password,
    String? rePassword,
  }) {
    return SignUpDetails(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
    );
  }
}
