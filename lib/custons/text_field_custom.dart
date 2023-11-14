import 'package:flutter/material.dart';

import '../constant.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? autofocus;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  const CustomTextField(
      {super.key,
      required this.controller,
      this.autofocus = false,
      this.onChanged,
      this.onSubmitted});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kTextFieldBorderColor,
          ),
        ),
      ),
      controller: widget.controller,
      autofocus: widget.autofocus ?? false,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}
