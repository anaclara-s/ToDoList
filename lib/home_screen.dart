import 'package:flutter/material.dart';

import 'open_dialog_future.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  openDialog(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline_rounded),
                    SizedBox(width: 10),
                    Text('Adicionar item')
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  openDialog(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline_rounded),
                    SizedBox(width: 10),
                    Text('Adicionar item')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
