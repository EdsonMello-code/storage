import 'dart:io';

import 'package:image_picker/image_picker.dart';

mixin ChooseFileMixin {
  Future<File?> pickImageFromGallery() async {
    final xImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    return xImage == null ? null : File(xImage.path);
  }
}
