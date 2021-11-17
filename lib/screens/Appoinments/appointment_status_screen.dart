import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/screens/Appoinments/slot_booking_screen.dart';
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
  final user = FirebaseAuth.instance.currentUser;

  // Future<bool> checkIfDocExists() async {
  //   var doc = await FirebaseFirestore.instance
  //       .collection('Appointments')
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       date = DateFormat.yMMMMd()
  //           .format(value.data()!['dateTime'].toDate())
  //           .toString();
  //       time = DateFormat.jm()
  //           .format(value.data()!['dateTime'].toDate())
  //           .toString();
  //       photoURL = value.data()!['photoURL'];
  //       displayName = value.data()!['displayName'];
  //       status = value.data()!['status'];
  //     });
  //   });
  //   setState(() async {
  //     isBooked = await doc.exists;
  //   });
  //   print("Inside CheckDocFunction");
  //   print("Returning a non null value");
  //   return isBooked;
  // }

  Future checkIfDocExists() async {
    var doc = await FirebaseFirestore.instance
        .collection('Appointments')
        .doc(user!.uid)
        .get();
    if (doc.exists) {
      date = DateFormat.yMMMMd()
          .format(doc.data()!['dateTime'].toDate())
          .toString();
      time =
          DateFormat.jm().format(doc.data()!['dateTime'].toDate()).toString();
      photoURL = doc.data()!['photoURL'];
      displayName = doc.data()!['displayName'];
      status = doc.data()!['status'];
    }

    setState(() {
      isBooked = doc.exists;
    });
    return isBooked;
    // return doc.exists;
  }

  @override
  void initState() {
    super.initState();
    // isBooked = checkIfDocExists();
    // _isBooked = checkIfDocExists() as bool?;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: checkIfDocExists(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // } else
            if (isBooked == true) {
              return Scaffold(
                backgroundColor: Colors.cyan.withOpacity(0.8),
                appBar: AppBar(
                  title: const Text(
                    'Appointment Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.cyan,
                  centerTitle: true,
                  shadowColor: Colors.blue.shade800,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(13.0),
                      margin: const EdgeInsets.all(37.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.82,
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40.0,
                          ),
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                NetworkImage(user!.photoURL as String),
                            //TODO: Attach background image as their profile picture from their google account
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            // 'NAME OF THE CLIENT',
                            displayName,
                            //TODO: Update the name of the client
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25.0,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            'Date of Appointment:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          const Text(
                            'Time of Appointment:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            'Appointment Status:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                              // ' Pending',
                              status,
                              style: status == 'Pending'
                                  ? TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.yellow.shade800,
                                    )
                                  : TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green.shade800,
                                    )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return AppointmentsHome();
            }
          }
          // else {
          //   print("snapshot data" + snapshot.hasData.toString());
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          // }
          ),
    );
  }
}
