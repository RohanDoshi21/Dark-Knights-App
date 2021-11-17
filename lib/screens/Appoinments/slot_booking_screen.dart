//import 'package:appointment_status/screens/appointment_status_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// import 'appointment_status_screen.dart';

// ignore: use_key_in_widget_constructors
class AppointmentsHome extends StatefulWidget {
  @override
  _AppointmentsHomeState createState() => _AppointmentsHomeState();
}

DateTime combine(DateTime date, TimeOfDay? time) => DateTime(
    date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

class _AppointmentsHomeState extends State<AppointmentsHome> {
  late DateTime _myDateTime;
  String date = '_______';
  TimeOfDay time = TimeOfDay.now();
  DateTime appointmentDateTime = DateTime.now();

  String getTiming() {
    //will return the timing in a string format
    // ignore: unnecessary_null_comparison
    if (time == null) {
      return '___';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      return '$hours: $minutes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan.shade200.withOpacity(0.9), //temporary color
      appBar: AppBar(
        title: const Text(
          'Book an appointment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(
          Icons.event_available_outlined,
          color: Colors.white,
        ),
        shadowColor: Colors.blueGrey.shade900,
        backgroundColor:
            Colors.cyan, //temporary color added //to be changed later
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              // margin: const EdgeInsets.(37.0),
              margin: const EdgeInsets.symmetric(horizontal: 37),
              decoration: BoxDecoration(
                color: Colors.cyan.shade800.withOpacity(0.4),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              width: MediaQuery.of(context).size.width * 0.82,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Choose a suitable date',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _myDateTime = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                      ))!;
                      setState(() {
                        date = DateFormat('dd/MM/yy').format(_myDateTime);
                        appointmentDateTime = _myDateTime;
                      });
                    },
                    child: const Text('Choose date'),
                  ),
                  const Divider(
                    height: 30.0,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Choose a time slot',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    getTiming(),
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() {
                        time = newTime!;
                        appointmentDateTime =
                            combine(appointmentDateTime, time);
                      });
                    },
                    child: const Text(
                      'Choose timing',
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Note:This timing would have to be changed if the CA isn\'t  available in this slot.',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser!;
                FirebaseFirestore.instance
                    .collection('Appointments')
                    .doc(user.uid)
                    .set({
                  'displayName': user.displayName,
                  'email': user.email,
                  'uid': user.uid,
                  'dateTime': appointmentDateTime,
                  'photoURL': user.photoURL,
                  'status': 'Pending',
                });

                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => const AppDrawer()));

                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }

                Fluttertoast.showToast(
                  msg: 'Date and time have been saved',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.7),
                  textColor: Colors.white,
                  fontSize: 20.0,
                );
              },
              child: const Text(
                'CONFIRM DATE AND TIME',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent.shade400.withOpacity(0.6),
                shadowColor: Colors.green.shade800,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
