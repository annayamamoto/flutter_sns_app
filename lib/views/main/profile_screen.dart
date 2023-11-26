import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/details/rounded_button.dart';
import 'package:flutter_sns_app/details/user_image.dart';
import 'package:flutter_sns_app/models/main/profile_model.dart';
import 'package:flutter_sns_app/models/main_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        profileModel.croppedFile == null
            ? UserImage(
                length: 100.0,
                userImageURL: mainModel.firestoreUser.userImageURL,
              )
            : FutureBuilder<Uint8List?>(
                future: profileModel.croppedFile!.readAsBytes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(160.0),
                        child: Image.memory(snapshot.data!),
                      );
                    } else {
                      return Text('No image selected');
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
        RoundedButton(
          backgroundColor: Colors.deepPurpleAccent.shade400,
          widthRate: 0.85,
          text: "画像アップロード",
          onPressed: () async => await profileModel.uploadUserImage(
              currentUserDoc: mainModel.currentUserDoc),
        )
      ],
    );
  }
}
