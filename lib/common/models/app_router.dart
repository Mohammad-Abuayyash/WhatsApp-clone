import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/models/app_routes.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';
import 'package:whatsapp_clone/common/screens/error_screen.dart';
import 'package:whatsapp_clone/main.dart';
import 'package:whatsapp_clone/modules/auth/auth.dart';
import 'package:whatsapp_clone/modules/auth/screens/login_screen/login_page.dart';
import 'package:whatsapp_clone/modules/auth/screens/user_info_page/user_info_page.dart';
import 'package:whatsapp_clone/modules/auth/screens/verification_screen/verification_page.dart';
import 'package:whatsapp_clone/features/chat/chat_screen/chat_screen.dart';
import 'package:whatsapp_clone/modules/screens/home_page/screen/home_page.dart';
import 'package:whatsapp_clone/modules/screens/welcome/screens/welcome_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.authScreen:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case AppRoutes.welcomeScreen:
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        );
      case AppRoutes.verificationScreen:
        return MaterialPageRoute(
          builder: (_) => VerificationPage(
            phoneNumber: settings.arguments as String,
            OTP: settings.arguments as String,
            verification_id: settings.arguments as String,
          ),
        );
      case AppRoutes.userInfoScreen:
        return MaterialPageRoute(builder: (_) => const UserInfoPage());
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.chatScreen:
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                  receiver: settings.arguments as UserModel,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
        );
    }
  }

  static void push(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }

  static void pushReplacement(String routeName, {Object? arguments}) {
    navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pushAndRemoveUntil(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
