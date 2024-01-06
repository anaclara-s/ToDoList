import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../shared/constant.dart';
import '../delete_page.dart';
import 'todo_store.dart';

import '../../shared/widgets/custom_alert_dialog.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoStore _todoStore = TodoStore();

  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _todoStore.loadLists();
  }

  @override
  void dispose() {
    _todoStore.todoTextController.dispose();
    super.dispose();
  }

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
                      DeletePage(_todoStore, _todoStore.deletedTasks),
                ),
              );
            },
            icon: const Icon(
              Icons.delete_rounded,
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: TextFormField(
                      controller: _todoStore.todoTextController,
                      focusNode: _focusNode,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      onFieldSubmitted: (value) {
                        _focusNode.requestFocus();
                        if (_formKey.currentState!.validate()) {
                          _todoStore.addTask(value);
                        }
                      },
                      validator: (value) {
                        if ((value == null || value.isEmpty)) {
                          return 'Por Favor, preencha o campo';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Observer(
              builder: (_) => Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 197, 187, 186),
                  child: ReorderableListView(
                    shrinkWrap: true,
                    onReorder: ((oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final String item = _todoStore.tasks.removeAt(oldIndex);
                        _todoStore.tasks.insert(newIndex, item);
                      });
                    }),
                    children: _todoStore.tasks
                        .asMap()
                        .entries
                        .map((entry) => ListTile(
                              key: Key('${entry.key}-${entry.value}'),
                              title: Center(
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ),
                              leading: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  MdiIcons.unfoldMoreHorizontal,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  final resp = await CustomAlertDialog.instance
                                      .asyncConfirmDialog(
                                    context: context,
                                    title: 'Confirmar',
                                    textConfirm: 'Excluir',
                                    textCancel: 'Cancelar',
                                    content: Text(
                                        'Tem certeza que deseja excluir esse item?'),
                                  );
                                  if (resp != null && resp['resp'] == true) {
                                    String taskToDelete =
                                        _todoStore.tasks[entry.key];
                                    _todoStore.removeTask(taskToDelete);
                                  }
                                },
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
