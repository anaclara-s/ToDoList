import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../shared/widgets/custom_alert_dialog.dart';
import '../shared/widgets/custom_app_bar.dart';
import 'todo_page/todo_store.dart';

class DeletePage extends StatelessWidget {
  final TodoStore _todoStore;
  final List<String> deletedTasks;

  const DeletePage(this._todoStore, this.deletedTasks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Lixeira'),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.deleteAlert),
            onPressed: () async {
              final resp = await CustomAlertDialog.instance.asyncConfirmDialog(
                context: context,
                title: 'Atenção!',
                textConfirm: 'Excluir',
                textCancel: 'Cancelar',
                content: const Text(
                    'Tem certeza que deseja EXCLUIR PERMANENTEMENTE TODOS OS ITENS?\nA ação não poderá ser desfeita.'),
              );
              if (resp != null && resp['resp'] == true) {
                _todoStore.deleteAllTasks();
              }
            },
          )
        ],
      ),
      body: Observer(
        builder: (_) => _todoStore.deletedTasks.isEmpty
            ? const Center(child: Text('Nada na lixeira'))
            : ListView.builder(
                itemCount: _todoStore.deletedTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_todoStore.deletedTasks[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_forever_rounded),
                      onPressed: () async {
                        final resp =
                            await CustomAlertDialog.instance.asyncConfirmDialog(
                          context: context,
                          title: 'Atenção!',
                          textConfirm: 'Excluir',
                          textCancel: 'Cancelar',
                          content: const Text(
                              'Tem certeza que deseja EXCLUIR PERMANENTEMENTE esse item?\nA ação não poderá ser desfeita.\n'),
                        );
                        if (resp != null && resp['resp'] == true) {
                          _todoStore.deletedTasks.removeAt(index);
                        }
                      },
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.restore),
                      onPressed: () {
                        _todoStore.addTask(_todoStore.deletedTasks[index]);
                        _todoStore.deletedTasks.removeAt(index);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
