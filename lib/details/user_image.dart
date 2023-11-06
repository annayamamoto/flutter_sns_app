import 'package:flutter/material.dart';
import 'package:flutter_sns_app/details/circle_image.dart';

class UserImage extends StatelessWidget {
  const UserImage(
      {super.key, required this.length, required this.userImageURL});

  final double length;
  final String userImageURL;

  @override
  Widget build(BuildContext context) {
    return userImageURL.isEmpty
        ? Container(
            width: length,
            height: length,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent),
                shape: BoxShape.circle),
            child: const Icon(
              Icons.person,
            ),
          )
        : CircleImage(length: length, image: NetworkImage(userImageURL));
  }
}
