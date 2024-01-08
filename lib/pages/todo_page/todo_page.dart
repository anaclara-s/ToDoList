import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../delete_page.dart';
import 'todo_store.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/custom_text_form_field.dart';
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
      appBar: CustomAppBar(
        text: 'TO DO LIST',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.auto_delete,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DeletePage(_todoStore, _todoStore.deletedTasks),
                ),
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: CustomTextFormField(
                      hintText: 'Digite um item',
                      controller: _todoStore.todoTextController,
                      onFieldSubmitted: (value) {
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
                      focusNode: null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Observer(
              builder: (_) => _todoStore.tasks.isEmpty
                  ? Text('Lista vazia')
                  : Expanded(
                      child: ReorderableListView(
                        shrinkWrap: true,
                        onReorder: ((oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final String item =
                                _todoStore.tasks.removeAt(oldIndex);
                            _todoStore.tasks.insert(newIndex, item);
                            _todoStore.saveOrder();
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
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  leading: GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      MdiIcons.unfoldMoreHorizontal,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () async {
                                          String originalValue =
                                              _todoStore.tasks[entry.key];
                                          String newValue = '';
                                          final resp = await CustomAlertDialog
                                              .instance
                                              .asyncConfirmDialog(
                                            context: context,
                                            title: 'Edição',
                                            textConfirm: 'Salvar',
                                            textCancel: 'Cancelar',
                                            content: TextFormField(
                                              initialValue: originalValue,
                                              onChanged: (value) {
                                                newValue = value;
                                              },
                                            ),
                                          );
                                          if (resp != null &&
                                              resp['resp'] == true) {
                                            _todoStore.putTask(
                                                newValue, entry.key);
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.cancel_outlined,
                                          color:
                                              Color.fromARGB(255, 253, 97, 86),
                                        ),
                                        onPressed: () async {
                                          final resp = await CustomAlertDialog
                                              .instance
                                              .asyncConfirmDialog(
                                            context: context,
                                            title: 'Excluir item',
                                            textConfirm: 'Excluir',
                                            textCancel: 'Cancelar',
                                            content: const Text(
                                                'Tem certeza que deseja excluir esse item?'),
                                          );
                                          if (resp != null &&
                                              resp['resp'] == true) {
                                            String taskToDelete =
                                                _todoStore.tasks[entry.key];
                                            _todoStore.removeTask(taskToDelete);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
