import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';

class CurrentUserNotifier extends StateNotifier<UserModel?> {
  CurrentUserNotifier(UserModel? state) : super(null);

  Future<void> getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    state = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
  }

  Future<void> loadCurrentUser() async {
    await getCurrentUser();
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
