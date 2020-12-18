import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _messageController = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _messageController.clear();
    final userid = FirebaseAuth.instance.currentUser.uid;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    print(userData);
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': userid,
      'username': userData['username'],
      'userImage': userData['userImageUrl'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            enableSuggestions: true,
            controller: _messageController,
            decoration: InputDecoration(
              labelText: 'Send a Message..',
              labelStyle: TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
