import 'package:flutter/material.dart';
import 'package:flutter_sns_app/models/main_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            mainModel.currentUserDoc["userName"],
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ],
    );
  }
}
