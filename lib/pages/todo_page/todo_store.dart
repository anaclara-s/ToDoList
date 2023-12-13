import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../repositories/shared_preferences_repository.dart';

part 'todo_store.g.dart';

class TodoStore = TodoStoreBase with _$TodoStore;

abstract class TodoStoreBase with Store {
  final TextEditingController todoTextController = TextEditingController();

  @observable
  ObservableList<String> tasks = ObservableList<String>();

  Future<List<String>> loadList() async {
    List<String> list = SharedPreferencesRepository.getListString();
    tasks = ObservableList<String>.of(list);
    return list;
  }

  @action
  Future<void> addTask(String task) async {
    todoTextController.clear();
    tasks.add(task);
    await saveList(tasks);
  }

  @action
  Future<void> putTask(String task, index) async {
    tasks[index] = task;
    await saveList(tasks);
  }

  @action
  Future<void> removeTask(String task) async {
    tasks.remove(task);
    await saveList(tasks);
  }

  Future<void> saveList(List<String> list) async {
    await SharedPreferencesRepository.putStringList(list);
  }
}
