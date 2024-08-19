import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/app_colors.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          sender,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
        Material(
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                )
              : const BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
          elevation: 5.0,
          color: isMe ? AppColors.myMessageGreen : AppColors.otherMessageGrey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
