import 'package:flutter/material.dart';
import 'package:flutter_sns_app/details/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField(
      {super.key,
      required this.color,
      required this.borderColor,
      required this.shadowColor,
      this.onChanged,
      required this.passwordEditingController,
      required this.obscureText,
      required this.toggleObscureText});

  final void Function(String)? onChanged;
  final TextEditingController passwordEditingController;
  final bool obscureText;
  final void Function() toggleObscureText;
  final Color color;
  final Color borderColor;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: color,
      borderColor: borderColor,
      shadowColor: shadowColor,
      child: TextFormField(
        controller: passwordEditingController,
        keyboardType: TextInputType.visiblePassword,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: "パスワード",
            suffix: InkWell(
              onTap: toggleObscureText,
              child: obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            )),
      ),
    );
  }
}
