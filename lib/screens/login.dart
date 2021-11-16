import 'package:darkknightspict/Admin/initial_admin.dart';
import 'package:darkknightspict/initial_page.dart';
import 'package:darkknightspict/services/google_signin.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  SignIn().signInWithGoogle().then(
                        (_) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InitialPage(),
                          ),
                        ),
                      );
                },
                child: const Text("Google Sign-In"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InitialPageAdmin(),
                    ),
                  );
                },
                child: const Text("Admin Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
