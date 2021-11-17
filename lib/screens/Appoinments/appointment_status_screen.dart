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
  }

  @override
  Widget build(BuildContext context) {
    // final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: FutureBuilder(
          future: checkIfDocExists(),
          builder: (context, snapshot) {
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
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.82,
                      height: MediaQuery.of(context).size.height * 0.62,
                      child: Column(
                        children: [
                          SizedBox(
                            height: _height * 0.0178,
                          ),
                          CircleAvatar(
                            radius: _height * 0.064,
                            backgroundColor: Colors.grey,
                            //Profile Photo of Client
                            backgroundImage:
                                NetworkImage(user!.photoURL as String),
                          ),
                          SizedBox(
                            height: _height * 0.0256,
                          ),
                          Text(
                            // 'NAME OF THE CLIENT',
                            displayName,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: _height * 0.032,
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
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.0128,
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: _height * 0.0256,
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
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.0128,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: _height * 0.0256,
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
                                    )
                                  : TextStyle(
                                      fontSize: _height * 0.0256,
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
          }),
    );
  }
}
