import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? hintText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.validator,
    this.hintText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      autofocus: true,
      textAlign: TextAlign.center,
    );
  }
}
