import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/models/user_model.dart';

class CurrentUserNotifier extends StateNotifier<UserModel?> {
  CurrentUserNotifier(UserModel? state) : super(null);

  Future<String?> getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      return userDoc['username'];
    } else {
      return null;
    }
  }

  void setUser(UserModel user) {
    state = user;
  }
}

final CurrentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, UserModel?>(
  (ref) {
    return CurrentUserNotifier(null);
  },
);
