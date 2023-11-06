import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OpenDialogWidget extends StatefulWidget {
  const OpenDialogWidget({super.key});

  @override
  State<OpenDialogWidget> createState() => _OpenDialogWidgetState();
}

class _OpenDialogWidgetState extends State<OpenDialogWidget> {
  late TextEditingController controller;
  List<String> itemList = [];
  String texto = '';

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              final texto = await openDialog(context);
              if (texto == null || texto.isEmpty) return;
              setState(() {
                itemList.add(texto);
              });
            },
            child: const Row(
              children: [
                Icon(Icons.add_circle_outline_rounded),
                SizedBox(width: 10),
                Text('Adicionar item')
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView(
                onReorder: _onReorder,
                children: itemList
                    .asMap()
                    .entries
                    .map((entry) => _buildListTitle(entry.value, entry.key))
                    .toList()
                // .map((Widget w) => Container(
                //       key: ValueKey(w),
                //       child: w,
                //     ))
                // .toList(),
                ),
          ),
          TextButton(
            onPressed: () async {
              final texto = await openDialog(context);
              if (texto == null || texto.isEmpty) return;
              setState(() {
                itemList.add(texto);
              });
            },
            child: const Row(
              children: [
                Icon(Icons.add_circle_outline_rounded),
                SizedBox(width: 10),
                Text('Adicionar item')
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Adcionar item'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: addtask,
              child: const Text('Ok'),
            ),
          ],
        ),
      );

  Widget _buildListTitle(String item, int index) {
    // GlobalKey _listTileKey = GlobalKey();

    return Dismissible(
      key: Key(item),
      onDismissed: (direction) {
        setState(() {
          itemList.removeAt(index);
        });
      },
      child: ListTile(
        title: Text(item),
        leading: GestureDetector(
          onTap: () {
            if (index > 0) {
              setState(() {
                final String currentItem = itemList[index];
                itemList.removeAt(index);
                itemList.insert(index - 1, currentItem);
              });
            }
          },
          child: Icon(MdiIcons.unfoldMoreHorizontal),
        ),
        trailing: InkWell(
          onTap: () {
            setState(() {
              itemList.remove(item);
            });
          },
          child: Icon(MdiIcons.alphaX),
        ),
      ),
    );
  }

  void addtask() {
    setState(() {
      itemList.add(controller.text);
      controller.clear();
    });
    Navigator.of(context).pop();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = itemList.removeAt(oldIndex);
      itemList.insert(newIndex, item);
    });
  }
}
