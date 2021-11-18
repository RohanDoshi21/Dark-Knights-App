import 'package:darkknightspict/developers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: prefer_const_constructors

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  //-----------------------------------------------------------------------
  final List<DrawerItem> drawer = const [
    DrawerItem('Developers', Icons.laptop_chromebook_outlined, Developers()),
    DrawerItem('Logout', Icons.logout_rounded, Developers()),
  ];
  final user = FirebaseAuth.instance.currentUser;
  //-------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF11052C),
              const Color(0xff010413),
              const Color(0xff070b67).withOpacity(0.4),
              const Color(0xff010413),
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            tileMode: TileMode.repeated),
      ),
      child: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              // margin: const EdgeInsets.only(top: ),
              // padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                "CLOUD ACCOUNTING",
                style: TextStyle(
                    fontFamily: 'Lato', fontSize: 37, color: Colors.deepPurple),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
              child: ListTile(
                leading: CircleAvatar(
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(user!.photoURL!),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      user!.displayName!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                subtitle: user!.phoneNumber != null
                    ? Container(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          user!.email! + " " + user!.phoneNumber!,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 15.0),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Flexible(
                          child: Text(
                            user!.email!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15.0),
                          ),
                        ),
                      ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => drawer[index].widget));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              drawer[index].icon,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(drawer[index].name,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Lato'))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: drawer.length,
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final String name;
  final IconData icon;
  final Widget widget;

  const DrawerItem(this.name, this.icon, this.widget);
}
