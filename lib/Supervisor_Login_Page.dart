import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uosc/signUpLogin/appLoader.dart';

import 'Cleaner/Cleaners Dashboard/CleanersDashboard.dart';
import 'Services/Color.dart';
import 'Services/resuableTextField.dart';
import 'SignUpScreeen.dart';
import 'Supervisor/SignInNotifier.dart';
import 'Supervisor/Supervisor Dashboard/Supervisor Dashboard.dart';
import 'Supervisor/Supervisor Dashboard/signInController.dart';

class SupervisorLoginPage extends ConsumerStatefulWidget {
  const SupervisorLoginPage({super.key});

  @override
  ConsumerState<SupervisorLoginPage> createState() =>
      _SupervisorLoginPageState();
}

class _SupervisorLoginPageState extends ConsumerState<SupervisorLoginPage> {
  late SignInController _controller;

  @override
  void initState() {
    _controller = SignInController(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = ref.watch(signInNotifierProvider);
    final loader = ref.watch(apploaderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supervisor Login Page"),
        backgroundColor: const Color(0xFFCB2B93),
      ),
      body: loader == false
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                    20,
                    MediaQuery.of(context).size.height * 0.2,
                    20,
                    0,
                  ),
                  child: Column(
              children: <Widget>[
                logoWidget("assets/images/housekeeping.png"),
                      const SizedBox(height: 30),
                      reusableTextField(
                        "Enter Username",
                        Icons.person_outline,
                        false,
                        func: (value) => ref
                            .read(signInNotifierProvider.notifier)
                            .onChangedEmail(value),
                      ),
                      const SizedBox(height: 20),
                      reusableTextField(
                        "Enter Password",
                        Icons.lock_outline,
                        true,
                        func: (value) => ref
                            .read(signInNotifierProvider.notifier)
                            .onChangedPassword(value),
                      ),
                      const SizedBox(height: 30),
                      signInSignUPButton(
                  context,
                  true,
                        func: () => _controller.handleSignIn(context),
                      ),
                      signUpOption(context),
                    ],
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

Row signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
            "Don't have an account?", style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context, // Use the passed context
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
