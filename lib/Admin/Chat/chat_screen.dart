import 'package:darkknightspict/Admin/Chat/messages.dart';
import 'package:darkknightspict/Admin/Chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreenAdmin extends StatelessWidget {
  const ChatScreenAdmin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
      ),
      body: Column(
        children: const [
          Expanded(
            child: MessagesAdmin(),
          ),
          NewMessageAdmin(),
        ],
      ),
    );
  }
}
