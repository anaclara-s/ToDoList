import 'package:flutter/material.dart';

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
            child: Row(
              children: [
                Icon(Icons.add_circle_outline_rounded),
                SizedBox(width: 10),
                Text('Adicionar item')
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Text(itemList[index]);
              },
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
            child: Row(
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
          title: Text('Adcionar item'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: addtask,
              child: Text('Ok'),
            ),
          ],
        ),
      );
  void addtask() {
    setState(() {
      itemList.add(controller.text);
      controller.clear();
    });
    Navigator.of(context).pop();
  }
}
