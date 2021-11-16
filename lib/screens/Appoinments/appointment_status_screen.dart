import 'package:flutter/material.dart';
//import 'slot_booking_screen.dart';

class AppointmentStatus extends StatefulWidget {

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  AppointmentStatus({required this.date, required this.time});
  late final String date;
  late final String time;

  @override
  // ignore: no_logic_in_create_state
  _AppointmentStatusState createState() => _AppointmentStatusState(date,time);
}

class _AppointmentStatusState extends State<AppointmentStatus> {

   late String date;
   late String time;
   _AppointmentStatusState(this.date,this.time);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyan.withOpacity(0.8),
      appBar:AppBar(
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:const EdgeInsets.all(13.0),
              margin: const EdgeInsets.all(37.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              width: MediaQuery.of(context).size.width*0.82,
              height: MediaQuery.of(context).size.height*0.75,
              child: Column(
                children:  [
                  const SizedBox(
                    height: 40.0,
                  ),
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                    //TODO: Attach background image as their profile picture from their google account
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  const Text(
                    'NAME OF THE CLIENT',
                    //TODO: Update the name of the client
                    style: TextStyle(
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
                    ' Pending',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.yellow.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
