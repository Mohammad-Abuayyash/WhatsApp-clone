import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/feature/auth/widgets/custom_text_field.dart';
import 'package:whatsapp_clone/home_page/home_page.dart';

// ...

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  final _auth = FirebaseAuth.instance;
  final String phoneNumber = '';
  final String countryName = '';
  final String countryCode = '';
  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Jordan');
    countryCodeController = TextEditingController(text: '962');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryCodeController.dispose();
    countryNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

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
            icon: const Icon(
              Icons.more_vert,
              color: COLORS.greyDark,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
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
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              onTap: () {},
              controller: countryNameController,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: COLORS.greenDark,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    controller: countryCodeController,
                    prefixText: '+',
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'phone number',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Carrier charges may apply',
            style: TextStyle(color: COLORS.greyDark),
          ),
          const SizedBox(height: 40),
          CustomElevatedButton(
            onPressed: () async {
              // try {
              //   await _auth.verifyPhoneNumber(
              //     verificationCompleted:
              //         (PhoneAuthCredential credential) async {
              //       await _auth.signInWithCredential(credential);
              //       Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(
              //           builder: (context) => const HomePage(),
              //         ),
              //       );
              //     },
              //     verificationFailed: (FirebaseAuthException e) {
              //       if (e.code == 'invalid-phone-number') {
              //         debugPrint('The provided phone number is not valid.');
              //       }
              //       // Handle other errors
              //     },
              //     codeSent: (String verificationId, int? resendToken) async {
              //       // Update the UI - wait for the user to enter the SMS code
              //       String smsCode = 'xxxx';

              //       // Create a PhoneAuthCredential with the code
              //       PhoneAuthCredential credential =
              //           PhoneAuthProvider.credential(
              //               verificationId: verificationId, smsCode: smsCode);

              //       // Sign the user in (or link) with the credential
              //       await _auth.signInWithCredential(credential);
              //     },
              //     timeout: const Duration(seconds: 60),
              //     codeAutoRetrievalTimeout: (String verificationId) {
              //       // Auto-resolution timed out...
              //     },
              //   );
              // } catch (e) {
              //   debugPrint(e.toString());
              //   debugPrint('there is an error here');
              // }
            },
            text: 'Next',
            buttonWidth: MediaQuery.of(context).size.width * 0.4,
          ),
        ],
      ),
    );
  }
}
