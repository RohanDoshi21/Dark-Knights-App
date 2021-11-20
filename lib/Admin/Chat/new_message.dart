import 'package:darkknightspict/Admin/Chat/clientuid.dart';
import 'package:darkknightspict/Admin/admin_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessageAdmin extends StatefulWidget {
  const NewMessageAdmin({Key? key}) : super(key: key);
  @override
  _NewMessageAdminState createState() => _NewMessageAdminState();
}

class _NewMessageAdminState extends State<NewMessageAdmin> {
  final _controller = TextEditingController();
  var _enteredMesaage = "";

  void _sendMessage() async {
    // FocusScope.of(context).unfocus();

    FirebaseFirestore.instance
        .collection('Users')
        .doc(chatwithUID)
        .collection('Chats')
        .add({
      "displayName": AdminInfo.displayName,
      "phoneNumber": AdminInfo.phoneNumber,
      "email": AdminInfo.email,
      "photoURL": AdminInfo.photoURL,
      "uid": AdminInfo.uid,
      "createdAt": Timestamp.now(),
      "Message": _enteredMesaage,
    });
    FirebaseFirestore.instance.collection('Users').doc(chatwithUID).update({
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
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: TextField(
                textInputAction: TextInputAction.send,
                controller: _controller,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Send a message',
                ),
                onChanged: (val) {
                  setState(() {
                    _enteredMesaage = val;
                  });
                },
                onEditingComplete: (){},
              ),
            ),
          ),
          IconButton(
            onPressed: _enteredMesaage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(
              Icons.send,
              // color: Colors.black,
              color: Color(0xff8564d6),
            ),
          )
        ],
      ),
    );
  }
}
