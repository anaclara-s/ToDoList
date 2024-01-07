import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../shared/widgets/custom_app_bar.dart';
import 'todo_page/todo_store.dart';

class DeletePage extends StatelessWidget {
  final TodoStore _todoStore;
  final List<String> deletedTasks;

  const DeletePage(this._todoStore, this.deletedTasks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text('Deleted Tasks')),
      body: Observer(
        builder: (_) => _todoStore.deletedTasks.isEmpty
            ? Center(child: Text('Nada na lixeira'))
            : ListView.builder(
                itemCount: _todoStore.deletedTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_todoStore.deletedTasks[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.restore),
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
