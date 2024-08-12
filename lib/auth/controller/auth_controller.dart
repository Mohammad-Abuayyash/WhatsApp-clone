import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/providers/current_user.dart';
import 'package:whatsapp_clone/models/user_model.dart';

class AuthController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required email,
    required String password,
    required UserModel user,
    required WidgetRef ref,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(user.toMap().toString());
      ref.watch(CurrentUserProvider.notifier).setUser(user);
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      debugPrint('hello error: ' + e.toString());
    }
  }

  Future<void> signIn() async {}
}
