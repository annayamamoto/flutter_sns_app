import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/constants/themes.dart';
import 'package:flutter_sns_app/details/sns_bottom_navigation.dart';
import 'package:flutter_sns_app/details/sns_drawer.dart';
import 'package:flutter_sns_app/firebase_options.dart';
import 'package:flutter_sns_app/models/main_model.dart';
import 'package:flutter_sns_app/models/sns_bottom_navigation_model.dart';
import 'package:flutter_sns_app/models/themes_model.dart';
import 'package:flutter_sns_app/views/login_page.dart';
import 'package:flutter_sns_app/views/main/home_screen.dart';
import 'package:flutter_sns_app/views/main/profile_screen.dart';
import 'package:flutter_sns_app/views/main/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ユーザーがログインしているかどうかの確認
    final User? userLoggedIn = FirebaseAuth.instance.currentUser;
    final ThemesModel themeModel = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SNS app',
      theme: themeModel.isDarkTheme
          ? darkThemeData(context: context)
          : lightThemeData(context: context),
      home: userLoggedIn == null
          ? const LoginPage()
          : MyHomePage(
              title: 'SNS',
              themesModel: themeModel,
            ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.themesModel,
  });

  final String title;
  final ThemesModel themesModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainModel mainModel = ref.watch(mainProvider);
    final SnsBottomNavigationModel snsBottomNavigationModel =
        ref.watch(snsBottomNavigationProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      drawer: SNSDrawer(mainModel: mainModel, themesModel: themesModel),
      body: mainModel.isLoading
          ? const Text("Loading...")
          : PageView(
              controller: snsBottomNavigationModel.pageController,
              onPageChanged: (index) =>
                  snsBottomNavigationModel.onPageChanged(index: index),
              children: [
                HomeScreen(),
                SearchScreen(),
                ProfileScreen(mainModel: mainModel),
              ],
            ),
      bottomNavigationBar: SnsBottomNavigation(
        snsBottomNavigationModel: snsBottomNavigationModel,
      ),
    );
  }
}
