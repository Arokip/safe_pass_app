import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
    this.textInputAction = TextInputAction.done,
    this.hintText = '',
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
