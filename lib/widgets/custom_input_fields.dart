import 'package:flutter/material.dart';

class CustomInputFields extends StatelessWidget {
  final Function(String value) onSaved;
  final String regEx;
  final String hintText;
  final bool obscure;

  const CustomInputFields(
      {required this.onSaved,
      required this.regEx,
      required this.hintText,
      required this.obscure,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (saveValue) => onSaved(saveValue!),
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      obscureText: obscure,
      validator: (value) {
        return RegExp(regEx).hasMatch(value!) ? null : "Enter valid value";
      },
      decoration: InputDecoration(
        fillColor: const Color.fromRGBO(30, 29, 37, 1.0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        label: Text(
          hintText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}
