import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/details/sns_bottom_navigation.dart';
import 'package:flutter_sns_app/firebase_options.dart';
import 'package:flutter_sns_app/models/main_model.dart';
import 'package:flutter_sns_app/models/sns_bottom_navigation_model.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ユーザーがログインしているかどうかの確認
    final User? userLoggedIn = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: userLoggedIn == null
          ? const LoginPage()
          : const MyHomePage(title: 'SNS'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

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
      // Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             // RoundedButton(
      //             //   widthRate: 0.5,
      //             //   text: "サインアップページ",
      //             //   backgroundColor: Colors.orange.shade700,
      //             //   onPressed: () => routes.toSignupPage(context: context),
      //             // ),
      //             // RoundedButton(
      //             //   widthRate: 0.5,
      //             //   text: "ログインページ",
      //             //   backgroundColor: Colors.deepOrange.shade700,
      //             //   onPressed: () => routes.toLoginPage(context: context),
      //             // ),
      //             Center(
      //               child: Text(
      //                   "私の作成日は${mainModel.currentUserDoc["createdAt"].toString()}です。"),
      //             ),
      //             RoundedButton(
      //                 widthRate: 0.85,
      //                 text: "ログアウトする",
      //                 onPressed: () =>
      //                     mainModel.logout(context: context, ref: ref),
      //                 backgroundColor: Colors.grey.shade500)
      //           ],
      //         ),
      //       ),
      bottomNavigationBar: SnsBottomNavigation(
        snsBottomNavigationModel: snsBottomNavigationModel,
      ),
    );
  }
}
