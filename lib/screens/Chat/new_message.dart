import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMesaage = "";

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Chats')
        .add({
      "displayName": user.displayName,
      "phoneNumber": user.phoneNumber,
      "email": user.email,
      "photoURL": user.photoURL,
      "uid": user.uid,
      "createdAt": Timestamp.now(),
      "Message": _enteredMesaage,
    });
    FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
      "lastMessageTime": Timestamp.now(),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          //Textfield takes as much space as available therfore wrap it into expanded widget
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Send a message.."),
              onChanged: (val) {
                setState(() {
                  _enteredMesaage = val;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMesaage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
