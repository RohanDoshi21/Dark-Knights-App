import 'package:darkknightspict/Admin/Appoinments/admin_appointments.dart';
import 'package:darkknightspict/screens/Laws/laws.dart';
import 'package:flutter/material.dart';

import 'Files/file_home_admin.dart';
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
    LawsAndActs(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff000000),
        type: BottomNavigationBarType.fixed,
        // unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline_rounded),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_outlined),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Laws/Acts',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
