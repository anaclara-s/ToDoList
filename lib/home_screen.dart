import 'package:flutter/material.dart';

import 'open_dialog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 176, 245),
        elevation: 2,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Column(
            children: [
              OpenDialogWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
