import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/models/app_router.dart';
import 'package:whatsapp_clone/common/models/app_routes.dart';
import 'package:whatsapp_clone/common/utils/app_colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/modules/welcome/widgets/language_button.dart';
import 'package:whatsapp_clone/modules/welcome/widgets/privacy_and_terms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Image.asset(
                  "assets/images/circle.png",
                  color: AppColors.greenDark,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.welcomeTitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const PrivacyAndTerms(),
                CustomElevatedButton(
                  onPressed: () {
                    AppRouter.push(AppRoutes.loginScreen);
                  },
                  text: 'AGREE AND CONTINUE',
                ),
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
