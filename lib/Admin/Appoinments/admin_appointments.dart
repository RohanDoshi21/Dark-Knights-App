import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/Admin/Calender%20Package/flutter_clean_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../admin_info.dart';

class ClientStatus extends StatefulWidget {
  const ClientStatus({Key? key}) : super(key: key);

  @override
  _ClientStatusState createState() => _ClientStatusState();
}

class _ClientStatusState extends State<ClientStatus> {
  final Map<DateTime, List<CleanCalendarEvent>> _events = {};
  DateTime? selectedDate = DateTime.now();
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    const List<Tab> tabs = <Tab>[
       Tab(
          child: Text(
        'Calendar',
        style: TextStyle(
          fontFamily: 'Lato',
        ),
      )),
      Tab(
          child: Text(
        'Pending Requests',
        style: TextStyle(
          fontFamily: 'Lato',
        ),
      ))
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (BuildContext context) {
          TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {});
          return Scaffold(
            backgroundColor: const Color(0xff010413),
            appBar: AppBar(
              backgroundColor: const Color(0xff010413),
              title: const Text(
                'Appointments',
                style: TextStyle(
                    color: Color(0xff5ad0b5),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Lato'),
              ),
              bottom: const TabBar(
                tabs: tabs,
              ),
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Calendar(
                        onDateSelected: (now) {
                          setState(() {
                            selectedDate = now;
                          });
                          // print(selectedDate);
                        },
                        startOnMonday: true,
                        events: _events,
                        selectedColor: const Color(0xff5ad0b5),
                        todayColor: Colors.blue,
                        eventColor: Colors.white,
                        isExpanded: true,
                        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                        dayOfWeekStyle: const TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            fontFamily: 'Lato'),
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Appointments')
                              .orderBy('dateTime', descending: true)
                              .snapshots(),
                          builder: (ctx, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final details = snapshot.data!.docs;
                            final height = MediaQuery.of(context).size.height;
                            final width = MediaQuery.of(context).size.width;
                            return ListView.separated(
                              padding: const EdgeInsets.all(15),
                              itemCount: details.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: details[index]['status'] ==
                                              'Accepted' &&
                                          (isSameDay(
                                              selectedDate,
                                              details[index]['dateTime']
                                                  .toDate()))
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xff403ffc)
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          //width: MediaQuery.of(context).size.width*0.82,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width * 0.05,
                                              ),
                                              CircleAvatar(
                                                radius: width * 0.076,
                                                backgroundImage: NetworkImage(
                                                    details[index]['photoURL']),
                                                backgroundColor: Colors
                                                    .blue, //temporarily added
                                              ),
                                              SizedBox(
                                                width: width * 0.090,
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      details[index]
                                                          ['displayName'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            height * 0.028,
                                                        fontFamily: 'Lato',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      details[index]['email'],
                                                      style: TextStyle(
                                                        fontSize:
                                                            height * 0.015,
                                                        fontFamily: 'Lato',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.007,
                                                  ),
                                                  Text(
                                                    'Time: ' +
                                                        DateFormat.jm()
                                                            .format(details[
                                                                        index]
                                                                    ['dateTime']
                                                                .toDate())
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize: height * 0.020,
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : null,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Appointments')
                      .orderBy('dateTime', descending: true)
                      .snapshots(),
                  builder: (ctx, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final details = snapshot.data!.docs;
                    return ListView.separated(
                      padding: const EdgeInsets.all(15),
                      itemCount: details.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: details[index]['status'] == 'Pending'
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff403ffc)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  //width: MediaQuery.of(context).size.width*0.82,
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: NetworkImage(
                                            details[index]['photoURL']),
                                        backgroundColor:
                                            Colors.blue, //temporarily added
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Flexible(
                                            child: Text(
                                              details[index]['displayName'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22.0,
                                                fontFamily: 'Lato',
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              details[index]['email'],
                                              style: const TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            'Date: ' +
                                                DateFormat.MMMMd()
                                                    .format(details[index]
                                                            ['dateTime']
                                                        .toDate())
                                                    .toString(),
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            'Time: ' +
                                                DateFormat.jm()
                                                    .format(details[index]
                                                            ['dateTime']
                                                        .toDate())
                                                    .toString(),
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          IconButton(
                                            // accept button
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('Appointments')
                                                  .doc(details[index]['uid'])
                                                  .update({
                                                'status': "Accepted",
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(details[index]['uid'])
                                                  .collection('Chats')
                                                  .add({
                                                "displayName":
                                                    AdminInfo.displayName,
                                                "phoneNumber":
                                                    AdminInfo.phoneNumber,
                                                "email": AdminInfo.email,
                                                "photoURL": AdminInfo.photoURL,
                                                "uid": AdminInfo.uid,
                                                "createdAt": Timestamp.now(),
                                                "Message":
                                                    "Your Appoinment has been confirmed!",
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(details[index]['uid'])
                                                  .update({
                                                "lastMessageTime":
                                                    Timestamp.now(),
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                              size: 35.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          IconButton(
                                            //Delete Button
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('Appointments')
                                                  .doc(details[index]['uid'])
                                                  .delete();
                                              await FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(details[index]['uid'])
                                                  .collection('Chats')
                                                  .add({
                                                "displayName":
                                                    AdminInfo.displayName,
                                                "phoneNumber":
                                                    AdminInfo.phoneNumber,
                                                "email": AdminInfo.email,
                                                "photoURL": AdminInfo.photoURL,
                                                "uid": AdminInfo.uid,
                                                "createdAt": Timestamp.now(),
                                                "Message":
                                                    "Sorry for inconvinience, I am a bit busy at that time! Could you book an appointment at any other time perhaps?",
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(details[index]['uid'])
                                                  .update({
                                                "lastMessageTime":
                                                    Timestamp.now(),
                                              });
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
                                )
                              : null,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
