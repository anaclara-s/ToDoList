import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'constant.dart';

class DeleteScreen extends StatefulWidget {
  final List<String> deletedItems;
  const DeleteScreen({Key? key, required this.deletedItems}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lixeira'),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          width: 500,
          child: ListView.builder(
            itemCount: widget.deletedItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.deletedItems[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        MdiIcons.deleteRestore,
                        color: kIconColor,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: kIconRemoveColor,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
