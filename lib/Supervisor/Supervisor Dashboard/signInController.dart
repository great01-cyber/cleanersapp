import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:uosc/Cleaner/Cleaners%20Dashboard/CleanersDashboard.dart';
import '../../Services/popMessaging.dart';
import '../../signUpLogin/appLoader.dart';
import '../SignInNotifier.dart';
import '../loginRequestEntity.dart';

class SignInController {
  final WidgetRef ref;

  SignInController(this.ref);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<User?> handleSignIn(BuildContext context) async {
    final state = ref.read(signInNotifierProvider);
    final String email = state.email;
    final String password = state.password;

    emailController.text = email;
    passwordController.text = password;

    // 1) Required fields
    if (email.isEmpty || password.isEmpty) {
      toastInfo("Please enter email and password");
      return null;
    }

    // 2) Email format (optional but helpful)
    final emailRegEx = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegEx.hasMatch(email)) {
      toastInfo("Please enter a valid email address");
      return null;
    }

    // 3) Start loader
    ref.read(apploaderProvider.notifier).setLoaderValue(true);

    try {
      // 🔹 Sign in with Firebase
      final UserCredential cred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = cred.user;

      // 🔹 If email not verified, prompt and (optionally) resend
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        toastInfo(
            "Your email isn't verified. We've sent you a new verification email.");
        await FirebaseAuth.instance.signOut();
        return null;
      }

      // 🔹 Access user details
      if (user != null) {
        String? displayName = user.displayName;
        String? email = user.email;
        String uid = user.uid;
        String? photoUrl = user.photoURL;

        // Example toast — can be removed
        toastInfo("Signed in as $email (UID: $uid)");

        // Create login request entity
        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.avatar = photoUrl;
        loginRequestEntity.name = displayName;
        loginRequestEntity.type = 1;
        loginRequestEntity.open_id = uid;

        // Send data (placeholder function for now)
        await asyncPostAllData(loginRequestEntity);
      }
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CleanersDashboard()),
      );

      toastInfo("Signed in successfully!");
      // TODO: Navigate to your home screen if needed.
    } on FirebaseAuthException catch (e) {
      // Friendlier error messages
      switch (e.code) {
        case "user-not-found":
          toastInfo("No account found for that email.");
          break;
        case "wrong-password":
          toastInfo("Incorrect password. Please try again.");
          break;
        case "invalid-email":
          toastInfo("The email address is not valid.");
          break;
        case "user-disabled":
          toastInfo("This account has been disabled.");
          break;
        case "too-many-requests":
          toastInfo("Too many attempts. Try again later.");
          break;
        default:
          toastInfo(e.message ?? "Sign in failed. Please try again.");
      }
    } finally {
      // 4) Stop loader
      ref.read(apploaderProvider.notifier).setLoaderValue(false);
    }
  }

  /// Simulates sending data to your backend
  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    // TODO: Replace this with your API call
    print("Posting user data: ${loginRequestEntity.toJson()}");
  }
}
