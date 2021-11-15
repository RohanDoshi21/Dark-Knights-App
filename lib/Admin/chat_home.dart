import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/Admin/Chat/chat_screen.dart';
import 'package:darkknightspict/Admin/Chat/clientuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clients Messages!"),
      ),
      body: StreamBuilder(
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
                  const Divider(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        chatwithUID = _chatTile['uid'];
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreenAdmin(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        foregroundColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(_chatTile['photoURL']),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _chatTile['displayName'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat.jm()
                                .format(_chatTile['lastMessageTime'].toDate())
                                .toString(),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14.0),
                          ),
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
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                _chatTile['email'],
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
