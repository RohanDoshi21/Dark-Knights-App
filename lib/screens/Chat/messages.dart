import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/screens/Chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
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
            bool isMe = false;
            if (chatDocs[index]['uid'] != 'admin') {
              isMe = true;
            }
            return MessageBubble(
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
