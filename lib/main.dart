import 'package:flutter/material.dart';
import 'package:lista_tarefas/repositories/shared_preferences_repository.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesRepository.init();

  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}
