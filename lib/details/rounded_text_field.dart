import 'package:flutter/material.dart';
import 'package:flutter_sns_app/details/text_field_container.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    super.key,
    required this.keyboardType,
    this.onChanged,
    required this.controller,
    required this.color,
    required this.borderColor,
    required this.shadowColor,
  });

  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController controller;
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
          decoration: const InputDecoration(
            hintText: "メールアドレス",
          ),
          keyboardType: keyboardType,
          controller: controller,
          onChanged: onChanged),
    );
  }
}
