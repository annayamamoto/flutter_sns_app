import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        children: [
          TextFormField(
            controller: emailEditingController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => signupModel.email = text,
          ),
          TextFormField(
            controller: passwordEditingController,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (text) => signupModel.password = text,
            obscureText: signupModel.isObscure,
            decoration: InputDecoration(
                suffix: InkWell(
              child: signupModel.isObscure
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onTap: () => signupModel.toggleIsObscure(),
            )),
          ),
          signupModel.currentUser == null
              ? const Text('nullです')
              : const Text('nullじゃないです'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await signupModel.createUser(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
