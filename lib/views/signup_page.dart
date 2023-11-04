import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/details/rounded_button.dart';
import 'package:flutter_sns_app/details/rounded_password_field.dart';
import 'package:flutter_sns_app/details/rounded_text_field.dart';
import 'package:flutter_sns_app/models/signup_model.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupMainModel signupModel = ref.watch(signupMainProvider);
    final TextEditingController emailEditingController =
        TextEditingController(text: signupModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: signupModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('signup'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailEditingController,
            onChanged: (text) => signupModel.email = text,
            color: Colors.grey.shade50,
            shadowColor: Colors.deepPurple.shade300,
            borderColor: Colors.deepPurple.shade700,
          ),
          RoundedPasswordField(
            color: Colors.grey.shade50,
            shadowColor: Colors.deepPurple.shade300,
            borderColor: Colors.deepPurple.shade700,
            passwordEditingController: passwordEditingController,
            obscureText: signupModel.isObscure,
            toggleObscureText: () => signupModel.toggleIsObscure(),
          ),
          RoundedButton(
            text: "新規登録",
            widthRate: 0.85,
            backgroundColor: Colors.deepPurple.shade400,
            onPressed: () async =>
                await signupModel.createUser(context: context),
          )
        ],
      ),
    );
  }
}
