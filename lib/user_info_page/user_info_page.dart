import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/providers/image_provider.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/auth/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  late UserCredential currentUser;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pickImage = ref.read(imageProvider.notifier).pickImage();
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
              style: TextStyle(color: kColors.greyDark),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                pickImage;
              },
              child: Container(
                width: 135,
                height: 135,
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kColors.phoneIconBgColorDark,
                  image: DecorationImage(
                    image: FileImage(image!),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: image == null
                      ? const Icon(
                          Icons.add_a_photo_rounded,
                          color: kColors.phoneIconColorDark,
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
                  color: kColors.phoneIconColorDark,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomElevatedButton(
              onPressed: () {},
              text: 'Next',
              buttonWidth: 140,
            ),
          ],
        ),
      ),
    );
  }
}
