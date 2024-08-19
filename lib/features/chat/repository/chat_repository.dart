import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/models/chat_contact.dart';
import 'package:whatsapp_clone/common/models/message.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';
import 'package:whatsapp_clone/common/utils/snack_bar.dart';
import 'package:whatsapp_clone/main.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream(
      String recieverUserId) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots();
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel? recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    var recieverChatContact = ChatContact(
      name: senderUserData.username,
      profilePic: senderUserData.profileImageUrl,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );

    debugPrint(text);
    await _firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(_auth.currentUser!.uid)
        .set(
          recieverChatContact.toMap(),
        );

    var senderChatContact = ChatContact(
      name: recieverUserData!.username,
      profilePic: recieverUserData.profileImageUrl,
      contactId: recieverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubcollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String senderUsername,
    required String? recieverUserName,
  }) async {
    final message = Message(
      senderId: _auth.currentUser!.uid,
      recieverid: recieverUserId,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );

    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    await _firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(_auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required String text,
    required UserModel recieverUser,
    required UserModel senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();

      var messageId = const Uuid().v1();
      debugPrint(text);

      _saveDataToContactsSubcollection(
        senderUser,
        recieverUser,
        text,
        timeSent,
        recieverUser.uid,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUser.uid,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUser.username,
        recieverUserName: recieverUser.username,
        senderUsername: senderUser.username,
      );
    } catch (e) {
      showSnackBar(navigatorKey.currentContext!, content: e.toString());
    }
  }
}
