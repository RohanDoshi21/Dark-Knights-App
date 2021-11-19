import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:darkknightspict/Admin/Chat/chat_screen.dart';
// import 'package:darkknightspict/Admin/Chat/clientuid.dart';
import 'package:flutter/material.dart';

class FileHomeAdmin extends StatefulWidget {
  const FileHomeAdmin({Key? key}) : super(key: key);

  @override
  State<FileHomeAdmin> createState() => _FileHomeAdminState();
}

class _FileHomeAdminState extends State<FileHomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff010413),
      appBar: AppBar(
        backgroundColor: const Color(0xff403ffc),
        shadowColor: Colors.black,
        elevation: 2.0,
        title: const Text(
          'Client\'s Documents',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .orderBy('lastMessageTime', descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final _chats = snapshot.data.docs;
            return ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (BuildContext context, int index) {
                final _chatTile = _chats[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // setState(() {
                        //   chatwithUID = _chatTile['uid'];
                        // });
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const ChatScreenAdmin(),
                        //   ),
                        // );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xff403ffc), //suggest color
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          // focusColor: Color(0xff010413),
                          // selectedTileColor: Color(0xfff403ffc).withOpacity(0.3),
                          leading: CircleAvatar(
                            foregroundColor: Theme.of(context).primaryColor,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                NetworkImage(_chatTile['photoURL']),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _chatTile['displayName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato',
                                ),
                              ),
                              // Text(
                              //   DateFormat.jm()
                              //       .format(_chatTile['lastMessageTime'].toDate())
                              //       .toString(),
                              //   style: const TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 15.0,
                              //       fontFamily: 'Lato',
                              //     fontWeight: FontWeight.w700,
                              //   ),
                              // ),
                            ],
                          ),
                          subtitle: _chatTile['phoneNumber'] != null
                              ? Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    _chatTile['email'] +
                                        " " +
                                        _chatTile['phoneNumber'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    _chatTile['email'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 38,
                          ),
                        ),
                      ),
                    ),
                    // const Divider(
                    //   height: 10.0,
                    //   //color:Color(0xff5858f3),
                    //   color: Colors.white,
                    // ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
