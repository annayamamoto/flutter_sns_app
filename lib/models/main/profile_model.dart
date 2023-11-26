import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/constants/others.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';

final profileProvider = ChangeNotifierProvider((ref) => ProfileModel());

class ProfileModel extends ChangeNotifier {
  CroppedFile? croppedFile;

  String returnUuidV4() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

  String returnJpgFileName() => "${returnUuidV4()}.jpg";

  Future<String> uploadImageAndGetURL(
      {required String uid, required File file}) async {
    final String fileName = returnJpgFileName();
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    await storageRef.putFile(file);
    return storageRef.getDownloadURL();
  }

  Future<void> uploadUserImage(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    final xFile = await returnXFile();
    final File file = File(xFile.path);
    final String uid = currentUserDoc.id;
    croppedFile = await returnCroppedFile(xFile: xFile);
    final String url = await uploadImageAndGetURL(uid: uid, file: file);
    await currentUserDoc.reference.update({
      'userImageURL': url,
    });
    notifyListeners();
  }

  Future<Uint8List?> yourAsyncMethod(CroppedFile croppedFile) async {
    try {
      // CroppedFile からバイトデータを非同期的に取得する
      List<int> bytes = await croppedFile.readAsBytes();

      // Uint8List に変換して返す
      return Uint8List.fromList(bytes);
    } catch (e) {
      print('Error in yourAsyncMethod: $e');
      return null;
    }
  }
}
