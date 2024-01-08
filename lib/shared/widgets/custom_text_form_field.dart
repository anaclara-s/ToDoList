import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? initialValue;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.hintText,
    this.initialValue,
    this.onChanged,
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
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      autofocus: true,
      textAlign: TextAlign.center,
    );
  }
}
