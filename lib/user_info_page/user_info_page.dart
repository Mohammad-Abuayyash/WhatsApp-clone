import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/feature/auth/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late UserCredential currentUser;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> signIn() async {
    try {
      currentUser = await _auth.signInWithEmailAndPassword(
        email: '+962797857727_whats@email.com',
        password: '123456',
      );
      if (currentUser != null) {
        debugPrint(
            'Signed in successfully!'); 
        return true;
      } else {
        debugPrint('Sign-in failed.'); // Replace with error handling
        return false;
      }
    } catch (e) {
      debugPrint('Error signing in: $e'); // Handle errors appropriately
      return false;
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;
  final TextEditingController userNameController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        debugPrint(_image.toString());
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: _pickImage,
              child: Container(
                width: 135,
                height: 135,
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kColors.phoneIconBgColorDark,
                  image: DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: _image == null
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
