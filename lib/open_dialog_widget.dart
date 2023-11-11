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
  List<bool> isEditing = [];
  bool isEditingItem = false;
  String editedText = '';
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
      height: 800,
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              final texto = await openDialog(context);
              if (texto == null || texto.isEmpty) return;
              setState(() {
                itemList.add(texto);
                isEditing.add(false);
              });
            },
            child: const Row(
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: Color.fromARGB(255, 161, 99, 202),
                  size: 25,
                ),
                SizedBox(width: 10),
                Text(
                  'Adicionar item',
                  style: TextStyle(
                    color: Color.fromARGB(255, 161, 99, 202),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: _onReorder,
              children: itemList
                  .asMap()
                  .entries
                  .map((entry) => _buildListTitle(entry.value, entry.key))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Adcionar item',
            style: TextStyle(
              color: Color.fromARGB(255, 185, 129, 255),
            ),
          ),
          content: TextField(
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 185, 129, 255),
                ),
              ),
            ),
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Color.fromARGB(255, 130, 155, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (isEditingItem) {
                  setState(() {
                    itemList.remove(editedText);
                    itemList.add(controller.text);
                    isEditing.add(false);
                    controller.clear();
                    isEditingItem = false;
                  });
                } else {
                  addtask();
                }
              },
              child: isEditingItem
                  ? Icon(
                      Icons.check,
                      color: Color.fromARGB(255, 145, 130, 255),
                      size: 25,
                    )
                  : const Text(
                      'Ok',
                      style: TextStyle(
                        color: Color.fromARGB(255, 145, 130, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      );

  Widget _buildListTitle(String item, int index) {
    TextEditingController editingController = TextEditingController(text: item);
    String originalText = item;

    return Dismissible(
      key: Key('$item$index'),
      onDismissed: (direction) {
        setState(() {
          itemList.removeAt(index);
          isEditing.removeAt(index);
        });
      },
      child: ListTile(
        title: isEditing[index]
            ? TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 185, 129, 255),
                    ),
                  ),
                ),
                controller: editingController,
                autofocus: true,
                onChanged: (newText) {
                  setState(() {
                    itemList[index] = newText;
                  });
                },
                onSubmitted: (newText) {
                  setState(() {
                    isEditing[index] = false;
                  });
                },
              )
            : Text(item),
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
          child: Icon(
            MdiIcons.unfoldMoreHorizontal,
            color: const Color.fromARGB(255, 216, 159, 226),
            size: 25,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (isEditing[index]) {
                    itemList[index] = editingController.text;
                    isEditing[index] = false;
                  } else {
                    isEditing[index] = true;
                    editingController.text = itemList[index];
                    originalText = itemList[index];
                  }
                });
              },
              child: isEditing[index]
                  ? Icon(
                      Icons.check_circle_outline_rounded,
                      color: Color.fromARGB(255, 108, 32, 170),
                      size: 25,
                    )
                  : Icon(
                      Icons.create_rounded,
                      color: Color.fromARGB(255, 108, 32, 170),
                      size: 25,
                    ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (isEditing[index]) {
                    isEditing[index] = false;
                    editingController.text = originalText;
                  } else {
                    itemList.removeAt(index);
                    isEditing.removeAt(index);
                  }
                });
              },
              child: isEditing[index]
                  ? Icon(
                      Icons.cancel_outlined,
                      color: Color.fromARGB(255, 108, 32, 170),
                      size: 25,
                    )
                  : const Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 108, 32, 170),
                      size: 25,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void addtask() {
    setState(() {
      itemList.add(controller.text);
      isEditing.add(false);
      isEditingItem = false;
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
