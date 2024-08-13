import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/providers/current_user.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/user_info_page/user_info_page.dart';
import 'package:whatsapp_clone/verification/verification_page.dart';

class AuthController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> signUpWithPhoneNumber(BuildContext context,
      {required String phoneNumber}) async {
    String verification_id;
    int _resendToken = 0;
    String OTP = '000000';
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is not valid.');
          } else {
            debugPrint(e.toString());
          }
          debugPrint('error message: ${e.message}');
          debugPrint('error code: ${e.code}');
          debugPrint('error stackTrace: ${e.stackTrace}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          verification_id = verificationId;
          _resendToken = resendToken!;
          debugPrint('code is sent');

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please check your phone for the verification code.'),
          ));

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return VerificationPage(
                  phoneNumber: phoneNumber,
                  OTP: OTP,
                  verification_id: verification_id,
                );
              },
            ),
          );
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          verification_id = verificationId;
        },
        forceResendingToken: _resendToken,
      );
    } catch (e) {
      debugPrint('signUpWithPhoneNumberError: ${e.toString()}');
    }
  }

  Future<void> createUser({
    required UserModel user,
    required WidgetRef ref,
  }) async {
    try {
      debugPrint(user.toMap().toString());
      ref.watch(CurrentUserProvider.notifier).setUser(user);
      debugPrint('${user.username} ${user.phoneNumber}');
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      debugPrint('createUserError: $e');
    }
  }

  Future<void> verifyOTP(
    BuildContext context, {
    required String value,
    required String phoneNumber,
    required String verification_id,
    required String otp,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verification_id, smsCode: otp);
      UserCredential user = await _auth.signInWithCredential(credential);
      if (user.user != null) {
        // final key = encrypt.Key.fromSecureRandom(16);
        // final iv = encrypt.IV.fromSecureRandom(16);
        // final encrypter = encrypt.Encrypter(encrypt.AES(key));
        // final encrypted = encrypter.encrypt(password, iv: iv);
        // final decrypted = encrypter.decrypt(encrypted, iv: iv);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return UserInfoPage(
                phoneNumber: phoneNumber,
              );
            },
          ),
        );
      } else {
        debugPrint('no user created');
      }
    } catch (e) {
      debugPrint('verifyOTP_Error: ${e.toString()}');
    }
  }
}
