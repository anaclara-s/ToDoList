import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'constant.dart';
import 'custons/text_button_custom.dart';
import 'custons/text_field_custom.dart';

class OpenDialogWidget extends StatefulWidget {
  final Function(String) onItemDeleted;

  const OpenDialogWidget({
    Key? key,
    required this.onItemDeleted,
  }) : super(key: key);

  @override
  State<OpenDialogWidget> createState() => _OpenDialogWidgetState();
}

class _OpenDialogWidgetState extends State<OpenDialogWidget> {
  late TextEditingController controller;
  List<String> itemList = [];
  List<bool> isEditing = [];
  List<String> deletedItems = [];
  bool isEditingItem = false;
  String editedText = '';

  void _showSnackbar(String message, String deletedItem) {
    setState(() {
      deletedItems.add(deletedItem);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

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
    return ScaffoldMessenger(
      child: SizedBox(
        height: 500,
        child: Column(
          children: [
            TextButtonCustom(
              onPressed: () async {
                final texto = await openDialog(context);
                if (texto == null || texto.isEmpty) return;
                setState(() {
                  itemList.add(texto);
                  isEditing.add(false);
                });
              },
              buttonText: 'Adcionar item',
              iconData: Icons.add_circle_outline_rounded,
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
      ),
    );
  }

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Adcionar item',
            style: TextStyle(
              color: kTextFieldTextColor,
            ),
          ),
          content: CustomTextField(
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButtonCustom(
              onPressed: () {
                Navigator.of(context).pop();
              },
              buttonText: 'Cancelar',
            ),
            TextButtonCustom(
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
              buttonText: isEditingItem ? 'Check' : 'Ok',
              iconData: isEditingItem ? Icons.check : null,
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
        widget.onItemDeleted(item);
        _showSnackbar('Item movido para a lixeira', item);
      },
      child: ListTile(
        title: isEditing[index]
            ? CustomTextField(
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
            color: kIconColor,
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
                  ? const Icon(
                      Icons.check_circle_outline_rounded,
                      color: kIconAddColor,
                      size: 25,
                    )
                  : const Icon(
                      Icons.create_rounded,
                      color: kIconEditingColor,
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
                  widget.onItemDeleted(item);
                  _showSnackbar('Item movido para a lixeira', item);
                });
              },
              child: isEditing[index]
                  ? const Icon(
                      Icons.cancel_outlined,
                      color: kIconRemoveColor,
                      size: 25,
                    )
                  : const Icon(
                      Icons.close,
                      color: kIconRemoveColor,
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
