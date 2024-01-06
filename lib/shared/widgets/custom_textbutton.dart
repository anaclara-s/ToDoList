import 'package:flutter/material.dart';
import 'package:lista_tarefas/shared/constant.dart';

class CustomTextButton extends StatefulWidget {
  final void Function()? onPressed;
  final String buttonText;
  final IconData? iconData;
  final Widget? child;

  const CustomTextButton(
      {super.key,
      this.onPressed,
      required this.buttonText,
      this.iconData,
      this.child});

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: widget.child ??
          Row(
            children: [
              if (widget.iconData == null)
                const Icon(
                  Icons.add_circle_outline_rounded,
                  color: kTextFieldTextColor,
                  size: 25,
                ),
              const SizedBox(
                width: 15,
              ),
              if (widget.iconData != null) const SizedBox(width: 10),
              Text(
                widget.buttonText,
                style: const TextStyle(
                  fontSize: 18,
                  color: kTextFieldTextColor,
                ),
              ),
            ],
          ),
    );
  }
}
