import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';
import 'package:whatsapp_clone/common/providers/current_user.dart';
import 'package:whatsapp_clone/common/utils/app_colors.dart';
import 'package:whatsapp_clone/features/chat/repository/chat_repository.dart';
import 'package:whatsapp_clone/features/chat/widgets/message_bubble.dart';
import 'package:whatsapp_clone/features/chat/widgets/messages_stream.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.receiver});

  final UserModel receiver;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();

  String messageText = '';

  @override
  Widget build(BuildContext context) {
    var currentUser = ref.watch(CurrentUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.receiver.profileImageUrl),
            radius: 12,
          ),
          title: Text(widget.receiver.username),
          subtitle: Text(widget.receiver.phoneNumber),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.videocam_outlined,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.call_outlined,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroundImage.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Messages and calls are end-to-end\nencrypted. No one outisde of this chat, not \neven WhatsApp, can read or listen to them.\nLearn More',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color.fromARGB(255, 241, 190, 102)),
                    ),
                  ),
                ),
              ),
              MessagesStream(
                auth: _auth,
                receivedID: widget.receiver.uid,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                decoration:
                    const BoxDecoration(color: AppColors.backgroundDark),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.add_outlined),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.greyBackground,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 7),
                            hintText: 'Type your message here...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (messageTextController.text.isNotEmpty) {
                          ChatRepository().sendTextMessage(
                            text: messageTextController.text,
                            recieverUser: widget.receiver,
                            senderUser: currentUser!,
                          );
                          messageTextController.clear();
                        }
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          color: AppColors.greenDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
