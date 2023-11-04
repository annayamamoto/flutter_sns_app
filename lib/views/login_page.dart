import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/details/rounded_button.dart';
import 'package:flutter_sns_app/details/rounded_password_field.dart';
import 'package:flutter_sns_app/details/rounded_text_field.dart';
import 'package:flutter_sns_app/models/login_model.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginModel loginModel = ref.watch(loginProvider);
    final TextEditingController emailEditingController =
        TextEditingController(text: loginModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: loginModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailEditingController,
              color: Colors.grey.shade50,
              onChanged: (text) => loginModel.email = text,
              borderColor: Colors.purple.shade300,
              shadowColor: Colors.purple.shade700),
          RoundedPasswordField(
            color: Colors.grey.shade50,
            borderColor: Colors.purple.shade300,
            shadowColor: Colors.purple.shade700,
            passwordEditingController: passwordEditingController,
            obscureText: loginModel.isObscure,
            onChanged: (text) => loginModel.password = text,
            toggleObscureText: () => loginModel.toggleIsObscure(),
          ),
          RoundedButton(
            text: "ログイン",
            widthRate: 0.85,
            backgroundColor: Colors.purple.shade400,
            onPressed: () async => await loginModel.login(context: context),
          )
        ],
      ),
    );
  }
}
