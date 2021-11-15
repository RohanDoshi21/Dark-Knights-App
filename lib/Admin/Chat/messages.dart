import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/Admin/Chat/clientuid.dart';
import 'package:darkknightspict/Admin/Chat/message_bubble.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class MessagesAdmin extends StatelessWidget {
  const MessagesAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(chatwithUID)
          .collection('Chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        // final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) {
            bool isMe = true;
            if (chatDocs[index]['uid'] != 'admin') {
              isMe = false;
            }
            return MessageBubbleAdmin(
              chatDocs[index]['Message'],
              chatDocs[index]['displayName'],
              chatDocs[index]['photoURL'],
              isMe,
            );
          },
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
