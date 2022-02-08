import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final String hintText;
  final TextEditingController controller;
  Function(String)? onChanged;

  ReusableTextField({
    Key? key,
    required this.textInputAction,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.errorText,
    required this.hintText,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 1.0, color: Colors.grey))),
    );
  }
}