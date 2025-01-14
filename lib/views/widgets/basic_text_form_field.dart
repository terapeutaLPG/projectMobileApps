import 'package:flutter/material.dart';

class BasicTextFormField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final InputDecoration? decoration;

  const BasicTextFormField({
    required this.initialValue,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: isPassword,
      decoration: decoration ??
          InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
    );
  }
}
