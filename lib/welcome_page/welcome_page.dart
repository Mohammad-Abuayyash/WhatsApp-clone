import 'package:flutter/material.dart';
import 'package:whatsapp_clone/welcome_page/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/welcome_page/widgets/language_button.dart';
import 'package:whatsapp_clone/welcome_page/widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111b21),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Image.asset(
                  '/Users/boj/Desktop/whatsapp-clone/whatsapp_clone/assets/images/circle.png',
                  color: const Color(0xff00a884),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Welcome to Whatsapp',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const PrivacyAndTerms(),
                  CustomElevatedButton(
                      onPressed: () {}, text: 'AGREE AND CONTINUE'),
                  const LanguageButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
