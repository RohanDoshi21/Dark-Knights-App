import 'package:darkknightspict/bottombar.dart';
import 'package:darkknightspict/developers.dart';
// import 'package:darkknightspict/initial_page.dart';
import 'package:darkknightspict/screens/Appoinments/appointments.dart';
import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return ElasticDrawer(
      mainColor: Colors.white,
      drawerColor: const Color(0xff0A043C),
      mainChild: BottomBar(),
      drawerChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // InkWell(
          //   onTap: () {
          //     ElasticDrawerKey.drawer.currentState!.closeElasticDrawer(context);
          //     ElasticDrawerKey.navigator.currentState!.push(MaterialPageRoute(
          //         builder: (context) => const AppointmentsHome()));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 100),
          //     child: Container(
          //       margin: const EdgeInsets.only(bottom: 15),
          //       height: 50,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //           color: const Color(0xffFEF9EF),
          //           borderRadius: BorderRadius.circular(10)),
          //       child: const Text(
          //         'Home',
          //         style: TextStyle(
          //             color: Colors.black87,
          //             fontSize: 25,
          //             fontWeight: FontWeight.bold),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: () {
              ElasticDrawerKey.drawer.currentState!.closeElasticDrawer(context);
              ElasticDrawerKey.navigator.currentState!.push(
                  MaterialPageRoute(builder: (context) => const Developers()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xffFEF9EF),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Developers',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ElasticDrawerKey.drawer.currentState!.closeElasticDrawer(context);
              // ElasticDrawerKey.navigator.currentState!
              //     .push(MaterialPageRoute(builder: (context) => RedPage()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xffFEF9EF),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
