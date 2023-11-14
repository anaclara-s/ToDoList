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
  List<String> deletedItems = [];

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
                  builder: (context) =>
                      DeleteScreen(deletedItems: deletedItems),
                ),
              );
            },
            icon: const Icon(
              Icons.delete_rounded,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Column(
              children: [
                OpenDialogWidget(
                  onItemDeleted: (item) {
                    setState(() {
                      deletedItems.add(item);
                    });
                  },
                  deletedItems: deletedItems,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
