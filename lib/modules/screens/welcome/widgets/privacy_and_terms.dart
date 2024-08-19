import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/app_colors.dart';

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
              color: AppColors.greyDark,
            ),
            children: [
              TextSpan(
                text: 'Privacy Policy. ',
                style: TextStyle(
                  color: AppColors.blueDark,
                ),
              ),
              TextSpan(text: 'Tap "Agree and continue" to accept the '),
              TextSpan(
                text: 'Terms of Services.',
                style: TextStyle(
                  color: AppColors.blueDark,
                ),
              ),
            ]),
      ),
    );
  }
}
