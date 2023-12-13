// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoStore on TodoStoreBase, Store {
  late final _$tasksAtom = Atom(name: 'TodoStoreBase.tasks', context: context);

  @override
  ObservableList<String> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<String> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$addTaskAsyncAction =
      AsyncAction('TodoStoreBase.addTask', context: context);

  @override
  Future<void> addTask(String task) {
    return _$addTaskAsyncAction.run(() => super.addTask(task));
  }

  late final _$putTaskAsyncAction =
      AsyncAction('TodoStoreBase.putTask', context: context);

  @override
  Future<void> putTask(String task, dynamic index) {
    return _$putTaskAsyncAction.run(() => super.putTask(task, index));
  }

  late final _$removeTaskAsyncAction =
      AsyncAction('TodoStoreBase.removeTask', context: context);

  @override
  Future<void> removeTask(String task) {
    return _$removeTaskAsyncAction.run(() => super.removeTask(task));
  }

  @override
  String toString() {
    return '''
tasks: ${tasks}
    ''';
  }
}
