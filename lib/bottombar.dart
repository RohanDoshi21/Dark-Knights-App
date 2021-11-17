// import 'package:darkknightspict/screens/Appoinments/appointments.dart';
import 'package:darkknightspict/screens/Appoinments/appointment_status_screen.dart';
// import 'package:darkknightspict/screens/Appoinments/slot_booking_screen.dart';
import 'package:darkknightspict/screens/Chat/chat_screen.dart';
import 'package:darkknightspict/screens/Files/file_home.dart';
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
    const FileHome()
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
        currentIndex: pageIndex,
        onTap: gotoPage,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Appointment"),
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outline_rounded), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_upload_outlined), label: "Files"),
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
