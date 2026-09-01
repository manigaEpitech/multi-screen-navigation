import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final IconData? icon;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.icon,
    this.textInputType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,

        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(),
      ),
      keyboardType: textInputType,
      validator:
          validator ??
          (value) => value!.isEmpty ? 'Ce champs est obligatoir' : null,
    );
  }
}
