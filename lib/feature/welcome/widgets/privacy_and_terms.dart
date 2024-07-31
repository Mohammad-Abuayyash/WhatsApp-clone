import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
            text: 'Read our ',
            style: TextStyle(
              color: COLORS.greyDark,
            ),
            children: [
              TextSpan(
                text: 'Privacy Policy. ',
                style: TextStyle(
                  color: COLORS.blueDark,
                ),
              ),
              TextSpan(text: 'Tap "Agree and continue" to accept the '),
              TextSpan(
                text: 'Terms of Services.',
                style: TextStyle(
                  color: COLORS.blueDark,
                ),
              ),
            ]),
      ),
    );
  }
}
