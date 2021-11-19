import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/screens/Appoinments/slot_booking_screen.dart';
import 'package:darkknightspict/screens/Drawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'slot_booking_screen.dart';

class AppointmentStatus extends StatefulWidget {
  const AppointmentStatus({Key? key}) : super(key: key);

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

  @override
  // ignore: no_logic_in_create_state
  _AppointmentStatusState createState() => _AppointmentStatusState();
}

class _AppointmentStatusState extends State<AppointmentStatus> {
  // ignore: unused_field
  late final String photoURL;
  late final String displayName;
  late final String date;
  late final String time;
  late final String status;
  bool? isBooked;
  double xOffeset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double val = 0;
  bool isDrawerOpen = false;
  final user = FirebaseAuth.instance.currentUser;

  Future checkIfDocExists() async {
    var doc = await FirebaseFirestore.instance
        .collection('Appointments')
        .doc(user!.uid)
        .get();
    bool docStatus = doc.exists;
    if (doc.exists) {
      date = DateFormat.yMMMMd()
          .format(doc.data()!['dateTime'].toDate())
          .toString();
      time =
          DateFormat.jm().format(doc.data()!['dateTime'].toDate()).toString();
      photoURL = doc.data()!['photoURL'];
      displayName = doc.data()!['displayName'];
      status = doc.data()!['status'];
      if (Timestamp.now().compareTo(doc.data()!['dateTime']) > 0) {
        // print("Deleting Document!");
        if (DateTime.now()
                .difference(doc.data()!['dateTime'].toDate())
                .inHours >=
            1) {
          await FirebaseFirestore.instance
              .collection('Appointments')
              .doc(user!.uid)
              .delete();
          docStatus = false;
        }
      }
    }

    setState(() {
      isBooked = docStatus;
    });

    return isBooked;
  }

  @override
  Widget build(BuildContext context) {
    // final _width = MediaQuery.of(context).size.width;
    final rightSlide = MediaQuery.of(context).size.width * 0.7;

    final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        color: const Color(0xff010413),
        child:
            // Scaffold(
            // backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   title: const Text(
            //     'Appointment Status',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   backgroundColor: Colors.cyan,
            //   centerTitle: true,
            //   shadowColor: Colors.blue.shade800,
            // ),
            // body:
            Stack(
          children: [
            const NavDrawer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isDrawerOpen ? 15 : 0),
                color: const Color(0xff010413),
              ),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(xOffeset, yOffset, 0)
                ..scale(scaleFactor),
              child: Column(
                children: [
                  Container(
                    color: const Color(0xff010413),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: isDrawerOpen
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      xOffeset = 0;
                                      yOffset = 0;
                                      scaleFactor = 1;
                                      isDrawerOpen = false;
                                      val = 0;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_left_outlined,
                                    size: 35,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      xOffeset = rightSlide;
                                      yOffset = 110;
                                      scaleFactor = 0.7;
                                      isDrawerOpen = true;
                                      val = 1;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Color(0xff5ad0b5),
                                  ),
                                ),
                        ),
                        const Text(
                          'Appointments',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 22,
                            color: Color(0xff5ad0b5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: FutureBuilder(
                      future: checkIfDocExists(),
                      builder: (context, snapshot) {
                        if (isBooked == true) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(13.0),
                                margin: const EdgeInsets.all(37.0),
                                decoration: const BoxDecoration(
                                  color: Color(0xff403ffc),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.82,
                                height:
                                    MediaQuery.of(context).size.height * 0.62,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: _height * 0.0178,
                                    ),
                                    CircleAvatar(
                                      radius: _height * 0.064,
                                      backgroundColor: Colors.grey,
                                      //Profile Photo of Client
                                      backgroundImage: NetworkImage(
                                          user!.photoURL as String),
                                    ),
                                    SizedBox(
                                      height: _height * 0.0256,
                                    ),
                                    Text(
                                      // 'NAME OF THE CLIENT',
                                      displayName,
                                      style: TextStyle(
                                        // color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: _height * 0.032,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.0384,
                                    ),
                                    Text(
                                      'Date of Appointment:',
                                      style: TextStyle(
                                        fontSize: _height * 0.0256,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.0128,
                                    ),
                                    Text(
                                      date,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _height * 0.0256,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.0512,
                                    ),
                                    Text(
                                      'Time of Appointment:',
                                      style: TextStyle(
                                        fontSize: _height * 0.0256,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.0128,
                                    ),
                                    Text(
                                      time,
                                      style: TextStyle(
                                        // color: Colors.black,
                                        fontSize: _height * 0.0256,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.0384,
                                    ),
                                    Text(
                                      'Appointment Status:',
                                      style: TextStyle(
                                        fontSize: _height * 0.0256,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.0128,
                                    ),
                                    Text(
                                        // ' Pending',
                                        status,
                                        style: status == 'Pending'
                                            ? TextStyle(
                                                fontSize: _height * 0.0256,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.yellow.shade800,
                                                fontFamily: 'Lato',
                                              )
                                            : TextStyle(
                                                fontSize: _height * 0.0256,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.greenAccent.shade400,
                                                fontFamily: 'Lato',
                                              )),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return AppointmentsHome();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
