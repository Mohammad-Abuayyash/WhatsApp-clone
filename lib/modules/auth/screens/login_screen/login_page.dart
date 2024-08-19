import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatsapp_clone/modules/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/common/utils/app_colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/common/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  late String phoneNumber;
  late String countryName;
  late String countryCode;

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
        backgroundColor: AppColors.backgroundDark,
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
              color: AppColors.greyDark,
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
                  color: AppColors.greyDark,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                      text: "What's my number?",
                      style: TextStyle(color: AppColors.blueDark)),
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
                color: AppColors.greenDark,
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
            style: TextStyle(color: AppColors.greyDark),
          ),
          const SizedBox(height: 40),
          CustomElevatedButton(
            onPressed: () async {
              AuthController authController = AuthController();
              await authController.signUpWithPhone(context,
                  phoneNumber: '+$countryCode$phoneNumber');
              FocusScope.of(context).unfocus();
            },
            text: 'Next',
            buttonWidth: MediaQuery.of(context).size.width * 0.4,
          ),
        ],
      ),
    );
  }
}
