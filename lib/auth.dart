import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/welcome/screens/welcome_page.dart';
import 'package:whatsapp_clone/home_page/home_page.dart';

class Auth extends StatelessWidget {
  /// [Auth] constructor
  const Auth({super.key});

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
