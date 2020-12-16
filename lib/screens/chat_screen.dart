import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/Irios9aQw4awIHAEe7Op/messages')
            .snapshots(),
        builder: (ctx, snapShot) =>
            snapShot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapShot.data.docs.length,
                    itemBuilder: (ctx, index) => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(snapShot.data.docs[index]['text']),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/Irios9aQw4awIHAEe7Op/messages')
              .add({
            'text': 'This is test Send',
          });
        },
      ),
    );
  }
}
