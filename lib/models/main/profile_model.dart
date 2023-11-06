import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/constants/others.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final profileProvider = ChangeNotifierProvider((ref) => ProfileModel());

class ProfileModel extends ChangeNotifier {
  XFile? xFile;

  String uuidV4() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

  String jpgFileName() => "${uuidV4()}.jpg";

  Future<String> uploadImageAndGetURL(
      {required String uid, required File file}) async {
    final String fileName = jpgFileName();
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    try {
      await storageRef.putData(await file.readAsBytes());
    } catch (e) {
      print(e);
    }
    return await storageRef.getDownloadURL();
  }

  Future<void> uploadUserImage(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    xFile = await returnXFile();
    final File file = File(xFile!.path);
    final String uid = currentUserDoc.id;
    final String url = await uploadImageAndGetURL(uid: uid, file: file);
    await currentUserDoc.reference.update({
      'userImageURL': url,
    });
  }
}
