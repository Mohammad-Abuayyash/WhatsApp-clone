import 'package:flutter/material.dart';
import 'package:whatsapp_clone/modules/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_text_field.dart';

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
                  if (value.length == 6) {
                    debugPrint('Verifying OTP');
                    AuthController authController = AuthController();
                    await authController.verifyOTP(
                      context,
                      value: value,
                      phoneNumber: widget.phoneNumber.trim(),
                      verification_id: widget.verification_id,
                      otp: widget.OTP,
                    );
                  }
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
                SizedBox(width: 20),
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
