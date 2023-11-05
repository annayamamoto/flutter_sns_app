import 'package:flutter/material.dart';
import 'package:flutter_sns_app/constants/bottomn_navigation_elements.dart';
import 'package:flutter_sns_app/models/sns_bottom_navigation_model.dart';

class SnsBottomNavigation extends StatelessWidget {
  const SnsBottomNavigation(
      {super.key, required this.snsBottomNavigationModel});

  final SnsBottomNavigationModel snsBottomNavigationModel;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: bottomNavigationElements,
      currentIndex: snsBottomNavigationModel.currentIndex,
      onTap: (index) => snsBottomNavigationModel.onTabTapped(index: index),
    );
  }
}
