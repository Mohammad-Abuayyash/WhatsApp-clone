import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:whatsapp_clone/welcome_page/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/welcome_page/widgets/language_button.dart';
import 'package:whatsapp_clone/welcome_page/widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.backgroundDark,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Image.asset(
                  '/Users/boj/Desktop/whatsapp-clone/whatsapp_clone/assets/images/circle.png',
                  color: COLORS.greenDark,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                const SizedBox(height: 50),
                const LanguageButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
