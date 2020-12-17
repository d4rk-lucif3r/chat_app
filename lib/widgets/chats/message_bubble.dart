import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  MessageBubble(this.message, this.isMe, {this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(20),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              border: Border.all(
                width: 2,
                color: isMe ? Colors.blueGrey : Theme.of(context).primaryColor,
              ),
            ),
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              message,
              softWrap: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ]);
  }
}
