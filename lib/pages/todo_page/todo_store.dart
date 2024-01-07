import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/shared_preferences_repository.dart';

part 'todo_store.g.dart';

class TodoStore = TodoStoreBase with _$TodoStore;

abstract class TodoStoreBase with Store {
  final TextEditingController todoTextController = TextEditingController();

  @observable
  ObservableList<String> tasks = ObservableList<String>();

  @observable
  ObservableList<String> deletedTasks = ObservableList<String>();

  Future<void> loadLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> activeTasks = prefs.getStringList('my_tasks') ?? [];
    List<String> deletedTasksList =
        prefs.getStringList('my_deleted_tasks') ?? [];
    tasks.addAll(activeTasks);
    deletedTasks.addAll(deletedTasksList);
  }

  @action
  Future<void> addTask(String task) async {
    todoTextController.clear();
    tasks.add(task);
    await saveList(tasks);
  }

  @action
  Future<void> putTask(String task, int index) async {
    tasks[index] = task;
    await saveList(tasks);
  }

  @action
  Future<void> removeTask(String task) async {
    tasks.remove(task);
    deletedTasks.add(task);
    await saveList(tasks);
    await saveDeletedList(deletedTasks);
  }

  @action
  Future<void> saveOrder() async {
    await SharedPreferencesRepository.putStringList(tasks, 'my_tasks');
  }

  Future<void> saveList(List<String> list) async {
    await SharedPreferencesRepository.putStringList(list, 'my_tasks');
  }

  Future<void> saveDeletedList(List<String> list) async {
    await SharedPreferencesRepository.putStringList(list, 'my_deleted_tasks');
  }
}
