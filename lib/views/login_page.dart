import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/models/login_model.dart';
import 'package:flutter_sns_app/models/main_model.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key, required this.mainModel});

  final MainModel mainModel;

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
        children: [
          TextFormField(
            controller: emailEditingController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => loginModel.email = text,
          ),
          TextFormField(
            controller: passwordEditingController,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (text) => loginModel.password = text,
            obscureText: loginModel.isObscure,
            decoration: InputDecoration(
                suffix: InkWell(
              child: loginModel.isObscure
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onTap: () => loginModel.toggleIsObscure(),
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async =>
            await loginModel.login(context: context, mainModel: mainModel),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
