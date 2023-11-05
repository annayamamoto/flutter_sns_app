import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final snsBottomNavigationProvider =
    ChangeNotifierProvider((ref) => SnsBottomNavigationModel());

class SnsBottomNavigationModel extends ChangeNotifier {
  int currentIndex = 0;

  late PageController pageController;

  SnsBottomNavigationModel() {
    init();
  }

  void init() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }

  void onPageChanged({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  void onTabTapped({required int index}) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void setPageController() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }
}
