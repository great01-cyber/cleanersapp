import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uos/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(apploaderProvider);
    final regProvider = ref.watch(signUpProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
      ),
      body: loader == false
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context)
                    .size
                    .width, // Make it take the full screen height
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      hexStringToColor("CB2B93"),
                      hexStringToColor("9546c4"),
                      hexStringToColor("5E61F4")
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        reusableTextField(
                          "Enter Username",
                          Icons.person_outline,
                          false,
                          _emailTextController,
                          func: (value) => ref
                              .read(signUpProvider.notifier)
                              .onChangedUsername(value),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        reusableTextField(
                          "Enter Email Id",
                          Icons.lock_outline,
                          false,
                          _passwordTextController,
                          func: (value) => ref
                              .read(signUpProvider.notifier)
                              .onChangedEmail(value),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        reusableTextField(
                          "Enter Password",
                          Icons.lock_outline,
                          false,
                          _passwordTextController,
                          func: (value) => ref
                              .read(signUpProvider.notifier)
                              .onChangedPassword(value),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        reusableTextField(
                          "Confirm password",
                          Icons.lock_outline,
                          false,
                          _passwordTextController,
                          func: (value) => ref
                              .read(signUpProvider.notifier)
                              .onChangedRePassword(value),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        signInSignUPButton(context, true, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupervisorDashboard()));
                        }),
                      ],
                    ),
                  ),
          ),
        ),
            )
          : const Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            )),
    );
  }
}
