// import 'package:darkknightspict/Admin/chat_home.dart';
import 'package:darkknightspict/Admin/initial_admin.dart';
import 'package:darkknightspict/drawer.dart';
// import 'package:darkknightspict/initial_page.dart';
// import 'package:darkknightspict/screens/Chat/chat_screen.dart';
import 'package:darkknightspict/services/google_signin.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              color: Colors.white.withOpacity(0.8),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.90,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset("assets/images/login2.jpg"),
                            ),
                          ),
                          const Text(
                            "Cloud Accounting",
                            style: TextStyle(fontSize: 25),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              "\"- An efficient and easy CA-Client interaction android application\"",
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Spacer(),
                          const Spacer(),
                          const Spacer(),
                          // Spacer(),
                          // Spacer(),
                          //google sign in
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xffE1E5EA),
                                borderRadius: BorderRadius.circular(25)),
                            child: InkWell(
                              onTap: () {
                                SignIn().signInWithGoogle().then(
                                      (_) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AppDrawer(),
                                        ),
                                      ),
                                    );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.asset(
                                            "assets/images/google.png")),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("Sign-In with Google")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xffE1E5EA),
                                borderRadius: BorderRadius.circular(25)),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 95,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child:
                                        Image.asset("assets/images/Admin.png"),
                                  ),
                                  const Text(
                                    "Admin Login",
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          // MaterialButton(
                          //   onPressed: () {
                          //     Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) =>
                          //             const InitialPageAdmin(),
                          //       ),
                          //     );
                          //   },
                          //   child: const Text("Admin Login"),
                          // ),
                          Spacer()
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
