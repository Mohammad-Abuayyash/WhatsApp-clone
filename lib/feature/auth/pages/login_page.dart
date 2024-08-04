import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/feature/auth/widgets/custom_text_field.dart';
import 'package:whatsapp_clone/home_page/home_page.dart';
import 'package:whatsapp_clone/verification/verification_page.dart';

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
  late String phoneNumber;
  late String countryName;
  late String countryCode;

  String fullPhoneNumber = '';

  String verification_id = '';
  String OTP = '';
  var _resendToken;

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Jordan');
    countryCodeController = TextEditingController();
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
              onTap: () {
                countryName = countryNameController.text;
              },
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
                    hintText: '+1',
                    onChanged: (value) {
                      countryCode = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'phone number',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      phoneNumber = value;
                    },
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
              await _auth.verifyPhoneNumber(
                phoneNumber: '+$countryCode$phoneNumber',
                verificationCompleted: (credential) {},
                verificationFailed: (FirebaseAuthException e) {
                  if (e.code == 'invalid-phone-number') {
                    debugPrint('The provided phone number is not valid.');
                  } else {
                    debugPrint(e.toString());
                  }
                  debugPrint('error message: ${e.message}');
                  debugPrint('error code: ${e.code}');
                  debugPrint('error stackTrace: ${e.stackTrace}');
                },
                codeSent: (String verificationId, int? resendToken) async {
                  verification_id = verificationId;
                  _resendToken = resendToken;
                  debugPrint('code is sent');

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Please check your phone for the verification code.'),
                  ));

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return VerificationPage(
                            phoneNumber: fullPhoneNumber,
                            OTP: OTP,
                            verification_id: verification_id);
                      },
                    ),
                  );
                },
                timeout: const Duration(seconds: 60),
                codeAutoRetrievalTimeout: (String verificationId) {
                  verification_id = verificationId;
                },
                forceResendingToken: _resendToken,
              );
            },
            text: 'Next',
            buttonWidth: MediaQuery.of(context).size.width * 0.4,
          ),
        ],
      ),
    );
  }
}
