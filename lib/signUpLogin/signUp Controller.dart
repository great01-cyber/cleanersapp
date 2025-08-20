import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uos/signUpLogin/signUp.dart';

import '../Services/popMessaging.dart';
import 'appLoader.dart';

class SignUpController {
  final WidgetRef ref;

  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(signUpProvider);

    String name = state.userName;
    String email = state.email;
    String password = state.password;
    String repassword = state.rePassword;

    // 1. Check empty fields
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        repassword.isEmpty) {
      toastInfo("Please fill in all fields");
      return;
    }

    // 2. Check password match
    if (password != repassword) {
      toastInfo("Your passwords don't match");
      return;
    }

    // 3. Password length
    if (password.length < 3) {
      toastInfo("Password must be at least 3 characters");
      return;
    }

    // 4. Username length
    if (name.length < 3) {
      toastInfo("Username must be at least 3 characters");
      return;
    }

    // 5. Email regex
    final emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegEx.hasMatch(email)) {
      toastInfo("Please enter a valid email address");
      return;
    }

    // ✅ Start loader
    ref.read(apploaderProvider.notifier).setLoaderValue(true);

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // 🔹 Create user in Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 🔹 Get the Firebase user
      User? user = userCredential.user;

      if (user != null) {
        // 🔹 Send verification email
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          toastInfo("Verification email sent to ${user.email}");
        } else {
          toastInfo("Email is already verified.");
        }
      }
    } on FirebaseAuthException catch (e) {
      toastInfo(e.message ?? "An error occurred");
    } finally {
      // ✅ Stop loader
      ref.read(apploaderProvider.notifier).setLoaderValue(false);
    }
  }
}
