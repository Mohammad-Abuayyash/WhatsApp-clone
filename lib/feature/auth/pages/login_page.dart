import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.loginPageTitle),
        elevation: 0,
        backgroundColor: COLORS.backgroundDark,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            splashColor: Colors.transparent,
            splashRadius: 22,
            iconSize: 22,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40),
            icon: Icon(
              Icons.more_vert,
              color: COLORS.greyDark,
            ),
          ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: 'WhatsApp will need to verify your phone number. ',
              style: TextStyle(
                color: COLORS.greyDark,
                height: 1.5,
              ),
              children: [
                TextSpan(
                    text: "What's my number?",
                    style: TextStyle(color: COLORS.blueDark)),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
