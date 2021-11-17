import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientDetails {
    late final String name;
    late final String emailId;
    //late final DateTime appointmentDate;
    //late final DateTime appointmentTime;
    // late final ImageProvider image;

    ClientDetails(
        {
          //required this.appointmentDate,
          //required this.appointmentTime,
          required this.emailId,
          //required this.image,
          required this.name,
        });
}

class ClientStatus extends StatefulWidget {
  const ClientStatus({Key? key}) : super(key: key);

  @override
  _ClientStatusState createState() => _ClientStatusState();
}

class _ClientStatusState extends State<ClientStatus> {
  List <ClientDetails>  details=[
    ClientDetails(
        //appointmentDate:
        //appointmentTime: ,
        emailId: 'EmailID',
      //image: NetworkImage(), TODO: Image to be added
        name: 'Client1',
        ),
    ClientDetails(
      // appointmentDate:
      // appointmentTime:
      emailId: 'EmailID',
      //image: NetworkImage(),
      name: 'Client2',
    ),
    ClientDetails(
      // appointmentDate:
      // appointmentTime:
      emailId: 'EmailID',
      //image: NetworkImage(),
      name: 'Client3',
    ),
    ClientDetails(
      // appointmentDate:
      // appointmentTime:
      emailId: 'EmailID',
      //image: NetworkImage(),
      name: 'Client4',
    ),
    ClientDetails(
      // appointmentDate:
      // appointmentTime:
      emailId: 'EmailID',
      //image: NetworkImage(),
      name: 'Client5',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          ' Client Appointments',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: details.length,
          itemBuilder: (context, index){
             return Container(
               decoration: BoxDecoration(
                 color: Colors.cyan.withOpacity(0.3),
                 borderRadius: BorderRadius.circular(20.0),
               ),
               //width: MediaQuery.of(context).size.width*0.82,
               height: MediaQuery.of(context).size.height*0.20,
               child: Row(
                 children: [
                   const SizedBox(
                     width: 30.0,
                   ),
                    CircleAvatar(
                     radius: 40.0,
                    //backgroundImage: details[index].image,
                     backgroundColor: Colors.blue,//temporarily added
                   ),
                   const SizedBox(
                     width:25.0,
                   ),
                   Column(
                     children: [
                       const SizedBox(
                         height: 40.0,
                       ),
                       Text(
                         details[index].name,
                         style: const TextStyle(
                           fontWeight:FontWeight.w600,
                           fontSize: 24.0,
                         ),
                       ),
                       Text(
                         details[index].emailId,
                         style: const TextStyle(
                           fontSize: 15.0,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                       const SizedBox(
                         height: 10.0,
                       ),
                       // Text(
                       //   'Date: ${details[index].appointmentDate}',
                       //   style: const TextStyle(
                       //     fontSize: 17.0,
                       //     fontWeight:FontWeight.w700,
                       //   ),
                       // ),
                       const SizedBox(
                         height: 10.0,
                       ),
                       // Text(
                       //   'Time: ${details[index].appointmentTime}',
                       //   style: const TextStyle(
                       //     fontSize: 17.0,
                       //     fontWeight:FontWeight.w700,
                       //   ),
                       // ),
                     ],
                   ),
                   const SizedBox(
                     width: 10.0,
                   ),
                   Column(
                     children: [
                       const SizedBox(
                         height: 30.0,
                       ),
                       IconButton(
                           onPressed:(){
                             //TODO: Update the client side UI
                           },
                         icon: const Icon(
                           Icons.check,
                           color: Colors.green,
                           size: 35.0,
                         ),
                       ),
                       const SizedBox(
                         height: 20.0,
                       ),
                       IconButton(
                         onPressed:(){
                           //TODO: Update the client side UI
                         },
                         icon: const Icon(
                           Icons.close,
                           color: Colors.red,
                           size: 35.0,
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             );
          },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
