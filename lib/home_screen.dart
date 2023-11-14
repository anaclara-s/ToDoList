import 'package:flutter/material.dart';

import 'delete_screen.dart';
import 'constant.dart';
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
        title: const Text('TO DO LIST'),
        centerTitle: true,
        backgroundColor: kAppBarColor,
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.delete_rounded,
            ),
          ),
        ],
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
