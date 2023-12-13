import 'package:flutter/material.dart';

import 'delete_page.dart';
import '../shared/constant.dart';
import 'todo_page/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  builder: (context) => DeletePage(deletedItems: deletedItems),
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
                TodoPage(
                  onItemDeleted: (item) {
                    setState(() {
                      deletedItems.add(item);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
