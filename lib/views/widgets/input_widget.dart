import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String placeHolder;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  const InputWidget(
      {super.key,
      required this.placeHolder,
      this.obscureText,
      this.onChanged,
      this.validator,
      this.keyboardType, this.prefix, this.suffix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: placeHolder,
        prefixIcon: prefix,
        suffixIcon: suffix
      ),
    );
  }
}
