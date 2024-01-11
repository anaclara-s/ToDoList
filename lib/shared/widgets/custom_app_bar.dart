import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final String text;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.backgroundColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      actions: actions,
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 68, 20, 124),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
