import 'package:flutter/material.dart';

import 'constant.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lixeira'),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
    );
  }
}
