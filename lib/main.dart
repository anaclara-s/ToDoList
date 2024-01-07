import 'package:flutter/material.dart';
import 'package:lista_tarefas/repositories/shared_preferences_repository.dart';

import 'pages/todo_page/todo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesRepository.init();
  runApp(
    MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const TodoPage(),
    ),
  );
}
