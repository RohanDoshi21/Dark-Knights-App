import 'package:darkknightspict/screens/Chat/chat_screen.dart';
import 'package:flutter/material.dart';

import 'screens/Appoinments/appointments.dart';
import 'screens/Files/file_home.dart';

class InitialPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const InitialPage();
  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _selectedIndex = 1;
  static const List<Widget> pages = <Widget>[
    AppointmentsHome(),
    ChatScreen(),
    FileHome(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("Cloud Accounting"),
      ),
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
