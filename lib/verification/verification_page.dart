import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:whatsapp_clone/auth/widgets/custom_text_field.dart';
import 'package:whatsapp_clone/user_info_page/user_info_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({
    super.key,
    required this.phoneNumber,
    required this.OTP,
    required this.verification_id,
  });

  final String verification_id;
  final String OTP;
  final String phoneNumber;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late TextEditingController codeController;
  bool showSpinner = false;
  String email = '';
  String password = '';

  Future<void> verifyOTP(String otp) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verification_id, smsCode: otp);
      UserCredential user = await _auth.signInWithCredential(credential);
      debugPrint('${credential.smsCode}: credential.smsCode');
      debugPrint('${widget.phoneNumber}: phoneNumber');
      if (user.user != null) {
        email = '${widget.phoneNumber.toString()}_whats@email.com';
        password = '123456';

        // final key = encrypt.Key.fromSecureRandom(16);
        // final iv = encrypt.IV.fromSecureRandom(16);
        // final encrypter = encrypt.Encrypter(encrypt.AES(key));
        // final encrypted = encrypter.encrypt(password, iv: iv);
        // final decrypted = encrypter.decrypt(encrypted, iv: iv);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return UserInfoPage(
                phoneNumber: widget.phoneNumber,
                email: email,
                password: password,
              );
            },
          ),
        );
      }
    } catch (e) {
      debugPrint('verifyOTP: ');
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your number'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text:
                    "You've tried to register ${widget.phoneNumber}, wait before requesting an SMS or call with your call.",
                style: const TextStyle(
                  color: kColors.greyDark,
                  height: 1.5,
                ),
                children: const [
                  TextSpan(
                    text: '\nWrong number?',
                    style: TextStyle(color: kColors.blueDark),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextField(
                controller: codeController,
                hintText: '- - -   - - -',
                fontSize: 30,
                autoFocus: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) async {
                  await verifyOTP(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter 6-digit code',
              style: TextStyle(color: kColors.greyDark),
            ),
            const SizedBox(height: 40),
            const Row(
              children: [
                Icon(
                  Icons.message,
                  color: kColors.greyDark,
                ),
                const SizedBox(width: 20),
                Text(
                  'Resend SMS',
                  style: TextStyle(
                    color: kColors.greyDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: kColors.blueDark.withOpacity(0.2)),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.phone,
                  color: kColors.greyDark,
                ),
                SizedBox(width: 20),
                Text(
                  'Call me',
                  style: TextStyle(
                    color: kColors.greyDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
