import 'package:flutter/material.dart';
import 'package:flutter_sns_app/main.dart';
import 'package:flutter_sns_app/models/main_model.dart';
import 'package:flutter_sns_app/views/acount_page.dart';
import 'package:flutter_sns_app/views/login_page.dart';
import 'package:flutter_sns_app/views/signup_page.dart';

void toMyApp({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: ((context) => const MyApp())));

void toSignupPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: ((context) => const SignupPage())));

void toLoginPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: ((context) => const LoginPage())));

void toAccountPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => AccountPage(mainModel: mainModel))));
