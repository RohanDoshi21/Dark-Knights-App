import 'package:darkknightspict/Admin/chat_home.dart';
import 'package:darkknightspict/screens/Chat/chat_screen.dart';
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
                            builder: (context) => const ChatScreen(),
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
                      builder: (context) => const ChatHome(),
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
