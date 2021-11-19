import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:darkknightspict/developers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login.dart';
// ignore: prefer_const_constructors

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  //-----------------------------------------------------------------------
  // final List<DrawerItem> drawer = const [
  //   DrawerItem('Developers', Icons.laptop_chromebook_outlined, Developers()),
  //   DrawerItem('Logout', Icons.logout_rounded, signOut()),
  // ];
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //-------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF11052C),
              const Color(0xff010413),
              const Color(0xff070b67).withOpacity(0.4),
              const Color(0xff010413),
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            tileMode: TileMode.repeated),
      ),
      child: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              // margin: const EdgeInsets.only(top: ),
              // padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                "CLOUD ACCOUNTING",
                style: TextStyle(
                    fontFamily: 'Lato', fontSize: 37, color: Colors.deepPurple),
              ),
            ),
            const Divider(color: Color(0xff5ad0b5)),
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: CircleAvatar(
                            foregroundColor: Theme.of(context).primaryColor,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(user!.photoURL!),
                          ),
                        ),
                        Text(
                          user!.displayName!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        user!.email!,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(color: Color(0xff5ad0b5)),
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Developers()));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.laptop_chromebook_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text('Developers',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: 'Lato'))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        headerAnimationLoop: false,
                        title: 'Signout?',
                        desc: 'Do you really want to signout?',
                        // ignore: deprecated_member_use
                        // btnOk: FlatButton(
                        //   child: const Text('Yes'),
                        //   onPressed: () async {

                        //     // Navigator.of(context).pop();
                        //   },
                        // ),
                        // ignore: deprecated_member_use
                        // btnCancel: FlatButton(
                        //   child: const Text('Cancel'),
                        //   color: Colors.red,
                        //   onPressed: () {
                        //     Navigator.of(context).pop();
                        //   },
                        // ),
                        btnOkOnPress: () async {
                          await _auth.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()),
                              (route) => false);
                        },
                        btnCancelOnPress: () {
                          // Navigator.of(context).pop();
                        },
                        dismissOnTouchOutside: false,
                      ).show();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.logout_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text('Logout',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: 'Lato'))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xff5ad0b5)),
          ],
        ),
      ),
    );
  }
}
