import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/modules/welcome/screens/welcome_page.dart';
import 'package:whatsapp_clone/modules/home_page/screen/home_page.dart';

class AuthScreen extends StatelessWidget {
  /// [AuthScreen] constructor
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.hasData.toString());
          return const HomePage();
        } else {
          return const WelcomePage();
        }
      },
    );
  }
}
