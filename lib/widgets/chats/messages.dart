import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  final userid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapShots) {
        if (chatSnapShots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chats = chatSnapShots.data.docs;

        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) => MessageBubble(
            chats[index]['text'],
            chats[index]['userId'] == userid ? true : false,
            chats[index]['username'],
            key: ValueKey(chats[index].documentID),
          ),
          itemCount: chats.length,
        );
      },
    );
  }
}
