import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/models/message.dart';
import 'package:whatsapp_clone/features/chat/repository/chat_repository.dart';
import 'package:whatsapp_clone/features/chat/widgets/message_bubble.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream({
    super.key,
    required this.auth,
    required this.receivedID,
  });

  final FirebaseAuth auth;
  final String receivedID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatRepository().getChatStream(receivedID),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        List<DocumentSnapshot> docs = snapshot.data!.docs;
        List<Message> messages = [];
        for (var document in docs) {
          messages
              .add(Message.fromMap(document.data() as Map<String, dynamic>));
        }
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.text;
          final messageSender = message.senderId;
          final timeSent = message.timeSent;

          final currentUser = auth.currentUser?.uid;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          debugPrint("send");
          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
