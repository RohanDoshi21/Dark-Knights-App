//import 'package:appointment_status/screens/appointment_status_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'appointment_status_screen.dart';

class AppointmentsHome extends StatefulWidget {

  @override
  _AppointmentsHomeState createState() => _AppointmentsHomeState();
}

class _AppointmentsHomeState extends State<AppointmentsHome> {
    late DateTime _myDateTime;
    String date='_______';
     TimeOfDay time=TimeOfDay.now();

    String getTiming(){//will return the timing in a string format
     if(time==null){
       return '___';
     }
     else{
       final hours=time.hour.toString().padLeft(2,'0');
       final minutes=time.minute.toString().padLeft(2,'0');
      return '$hours: $minutes';
     }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan.shade200.withOpacity(0.9),//temporary color
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
        backgroundColor: Colors.cyan,//temporary color added //to be changed later
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
              padding:EdgeInsets.all(15.0),
              margin: EdgeInsets.all(37.0),
              decoration: BoxDecoration(
                color: Colors.cyan.shade800.withOpacity(0.4),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              width: MediaQuery.of(context).size.width * 0.82,
              height: MediaQuery.of(context).size.height * 0.68,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                 Text(
                   'Choose a suitable date',
                   style: TextStyle(
                     color:Colors.white.withOpacity(0.7),
                     fontSize: 25.0,
                     fontWeight:FontWeight.w800,
                   ),
                 ),
                  const SizedBox(
                    height: 30.0,
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
                    height: 30.0,
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        _myDateTime= (
                            await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2050),
                        ))!;
                        setState(() {
                             date=DateFormat('dd/MM/yy').format(_myDateTime);
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
                    height: 20.0,
                  ),
                  Text(
                    'Choose a time slot',
                    style: TextStyle(
                      color:Colors.white.withOpacity(0.7),
                      fontSize: 25.0,
                      fontWeight:FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                  getTiming(),
                    style:  const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        final newTime= await showTimePicker(
                            context: context,
                            initialTime:TimeOfDay.now(),
                        );
                        setState(() {
                            time=newTime!;
                        });
                      },
                      child: const Text(
                        'Choose timing',
                      ),
                  ),
                  const SizedBox(
                    height: 30.0,
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
            ElevatedButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return AppointmentStatus(date: date, time: getTiming());
                }));
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
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
