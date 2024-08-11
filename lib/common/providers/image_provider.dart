import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageNotifier extends StateNotifier<File?> {
  ImageNotifier(File? state) : super(null);

  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      state = File(pickedFile.path);
      debugPrint(state.toString());
    } else {
      debugPrint('No image selected.');
    }
  }

  void setImage(File image) {
    state = image;
  }
}

final imageProvider = StateNotifierProvider<ImageNotifier, File?>(
  (ref) {
    return ImageNotifier(null);
  },
);
