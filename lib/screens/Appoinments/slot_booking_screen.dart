import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/bottombar.dart';
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
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff010413),
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          'Book an appointment',
          style: TextStyle(
              color: Color(0xff5ad0b5),
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato'),
        ),
        leading: const Icon(
          Icons.event_available_outlined,
          color: Color(0xff5ad0b5),
        ),
        shadowColor: Colors.blueGrey.shade900,
        backgroundColor: const Color(0xff010413),
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
              margin: const EdgeInsets.symmetric(horizontal: 37),
              decoration: const BoxDecoration(
                color: Color(0xff403ffc),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              width: MediaQuery.of(context).size.width * 0.82,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                children: [
                  SizedBox(
                    height: _height * 0.0128,
                  ),
                  Text(
                    'Choose a suitable date',
                    style: TextStyle(
                        fontSize: _height * 0.032,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Lato'),
                  ),
                  SizedBox(
                    height: _height * 0.0128,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        fontSize: _height * 0.0384,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'),
                  ),
                  SizedBox(
                    height: _height * 0.0128,
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
                  Divider(
                    height: _height * 0.0384,
                    thickness: 1.0,
                  ),
                  SizedBox(
                    height: _height * 0.0128,
                  ),
                  Text(
                    'Choose a time slot',
                    style: TextStyle(
                        fontSize: _height * 0.032,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Lato'),
                  ),
                  SizedBox(
                    height: _height * 0.0128,
                  ),
                  Text(
                    getTiming(),
                    style: TextStyle(
                        fontSize: _height * 0.0384,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'),
                  ),
                  SizedBox(
                    height: _height * 0.0128,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() {
                        time = newTime!;
                      });
                    },
                    child: const Text(
                      'Choose timing',
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.0128,
                  ),
                  const Text(
                    'Note:This timing would have to be changed if the CA isn\'t  available in this slot.',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Lato'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _height * 0.0384,
            ),
            ElevatedButton(
              onPressed: () {
                appointmentDateTime = combine(appointmentDateTime, time);
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
                  Future.delayed(const Duration(microseconds: 10));
                  Navigator.pop(context);
                }
                setState(() {
                  pageIndex = 0;
                });
                Fluttertoast.showToast(
                  msg: 'Date and time have been saved',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.7),
                  textColor: Colors.white,
                  fontSize: 20.0,
                );
              },
              child: Text(
                'CONFIRM DATE AND TIME',
                style: TextStyle(
                  fontSize: _height * 0.0256,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Lato'
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent.shade400.withOpacity(0.6),
                shadowColor: Colors.green.shade800,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
