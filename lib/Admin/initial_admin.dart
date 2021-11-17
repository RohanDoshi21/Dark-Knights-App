import 'package:darkknightspict/Admin/Appoinments/admin_appointments.dart';
import 'package:flutter/material.dart';

import 'Appoinments/appointments.dart';
import 'Files/file_home.dart';
import 'chat_home.dart';

class InitialPageAdmin extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const InitialPageAdmin();
  @override
  State<InitialPageAdmin> createState() => _InitialPageAdminState();
}

class _InitialPageAdminState extends State<InitialPageAdmin> {
  int _selectedIndex = 1;
  static const List<Widget> pages = <Widget>[
    // AppointmentsHomeAdmin(),
    ClientStatus(),
    ChatHome(),
    FileHomeAdmin(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // // drawer: AppDrawer(),
      // appBar: AppBar(
      //   title: const Text("Cloud Accounting"),
      // ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Appoinments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Files',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
