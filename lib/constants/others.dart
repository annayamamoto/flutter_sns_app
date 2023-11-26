import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile> returnXFile() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image!;
}

Future<CroppedFile?> returnCroppedFile({required XFile? xFile}) async {
  CroppedFile? result = await ImageCropper().cropImage(
    sourcePath: xFile!.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );
  return result;
}
