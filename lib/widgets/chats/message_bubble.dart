import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String username;
  final String userImageUrl;
  MessageBubble(this.message, this.isMe, this.username, this.userImageUrl,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(20),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                  color:
                      isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                  border: Border.all(
                    width: 2,
                    color:
                        isMe ? Colors.blueGrey : Theme.of(context).primaryColor,
                  ),
                ),
                width: 140,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.green,
                    ),
                    Text(
                      message,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                  ],
                ),
              ),
            ]),
        Positioned(
          top: 0,
          left: isMe ? null:125,
          right:isMe? 125: null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImageUrl),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
