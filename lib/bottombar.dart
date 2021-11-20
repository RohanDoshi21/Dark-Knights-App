// import 'package:darkknightspict/screens/Appoinments/appointments.dart';
import 'package:darkknightspict/screens/Appoinments/appointment_status_screen.dart';
// import 'package:darkknightspict/screens/Appoinments/slot_booking_screen.dart';
import 'package:darkknightspict/screens/Chat/chat_screen.dart';
import 'package:darkknightspict/screens/Files/file_home.dart';
import 'package:darkknightspict/screens/Laws/Laws.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  // static const routeName = 'BottomBar/';

  @override
  State<BottomBar> createState() => _BottomBarState();
}

int pageIndex = 0;

class _BottomBarState extends State<BottomBar> {
  PageController _pageController = PageController();
  List<Widget> pages = [
    // AppointmentsHome(),
    const AppointmentStatus(),
    const ChatScreen(),
    const FileHome(),
    const LawsAndActs(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: gotoPage,
        backgroundColor: const Color(0xff000000),
        // backgroundColor: Colors.white,
        items: const [
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
      ),
      body: PageView(
        children: pages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      pageIndex = page;
      // print(page);
    });
  }

  void gotoPage(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}
