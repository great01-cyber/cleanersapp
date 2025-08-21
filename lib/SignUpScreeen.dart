import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uos/HomePage.dart';
import 'package:uos/signUpLogin/appLoader.dart';
import 'package:uos/signUpLogin/signUp%20Controller.dart';
import 'package:uos/signUpLogin/signUp.dart';

import 'Services/Color.dart';
import 'Services/resuableTextField.dart';
import 'Supervisor/Supervisor Dashboard/Supervisor Dashboard.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late SignUpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignUpController(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(apploaderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
      ),
      body: loader == false
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546c4"),
                    hexStringToColor("5E61F4"),
                  ],
                  begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        MediaQuery.of(context).size.height * 0.1,
                        20,
                        20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 30),
                          reusableTextField(
                            "Enter Username",
                            Icons.person_outline,
                            false,
                            func: (value) => ref
                                .read(signUpProvider.notifier)
                                .onChangedUsername(value),
                          ),
                          const SizedBox(height: 20),
                          reusableTextField(
                            "Enter Email Id",
                            Icons.email_outlined,
                            false,
                            func: (value) => ref
                                .read(signUpProvider.notifier)
                                .onChangedEmail(value),
                          ),
                          const SizedBox(height: 30),
                          reusableTextField(
                            "Enter Password",
                            Icons.lock_outline,
                            true,
                            func: (value) => ref
                                .read(signUpProvider.notifier)
                                .onChangedPassword(value),
                          ),
                          const SizedBox(height: 30),
                          reusableTextField(
                            "Confirm Password",
                            Icons.lock_outline,
                            true,
                            func: (value) => ref
                                .read(signUpProvider.notifier)
                                .onChangedRePassword(value),
                          ),
                          const Spacer(), // pushes button to bottom
                          signInSignUPButton(
                            context,
                            false, // false = SignUp
                            () => _controller.handleSignUp(),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
            )
          : const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ),
    );
  }
}
