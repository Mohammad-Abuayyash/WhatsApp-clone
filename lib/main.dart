import 'package:flutter/material.dart';
import 'package:whatsapp_clone/home_page/home_page.dart';
import 'package:whatsapp_clone/welcome_page/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            background: const Color.fromRGBO(25, 25, 25, 0.5),
            primary: Colors.white,
            brightness: Brightness.dark),
      ),
      home: WelcomePage(),
    );
  }
}
