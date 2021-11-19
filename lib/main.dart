import 'package:darkknightspict/bottombar.dart';
import 'package:darkknightspict/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dark Knights App',
        theme: ThemeData.dark(),
        home: const BottomBar(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dark Knights App',
        theme: ThemeData.dark(),
        home: const LoginScreen(),
      );
    }
  }
}
