import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/models/app_router.dart';
import 'package:whatsapp_clone/common/models/app_routes.dart';
import 'package:whatsapp_clone/modules/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/common/providers/image_provider.dart';
import 'package:whatsapp_clone/common/utils/app_colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/common/widgets/custom_text_field.dart';
import 'package:whatsapp_clone/modules/home_page/screen/home_page.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key});

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  late final UserModel user;

  final _auth = FirebaseAuth.instance;

  final TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final imageProv = ref.read(imageProvider.notifier);
    final image = ref.watch(imageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Info'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text(
              'Please provide your name and an optional profile photo',
              style: TextStyle(color: AppColors.greyDark),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () async {
                await imageProv.pickImageFromGallery(context);
              },
              child: Container(
                width: 135,
                height: 135,
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.phoneIconBgColorDark,
                  image: DecorationImage(
                    image: image != null
                        ? FileImage(image) as ImageProvider
                        : const AssetImage("assets/images/circle.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: image == null
                      ? const Icon(
                          Icons.add_a_photo_rounded,
                          color: AppColors.phoneIconColorDark,
                          size: 48,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: CustomTextField(
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    hintText: 'Type your name here',
                    textAlign: TextAlign.left,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.emoji_emotions_outlined,
                  color: AppColors.phoneIconColorDark,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomElevatedButton(
              onPressed: () async {
                await AuthController().saveUserToFirebase(
                  context,
                  name: userNameController.text,
                  profilePic: image,
                  ref: ref,
                );

                if (_auth.currentUser != null) {
                  AppRouter.pushReplacement(AppRoutes.homeScreen);
                }
              },
              text: 'Next',
              buttonWidth: 140,
            ),
          ],
        ),
      ),
    );
  }
}
