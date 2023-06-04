import 'package:flutter/material.dart';
import 'package:simple_note/model/note.dart';
import 'package:simple_note/services/database_service.dart';
import 'package:simple_note/util/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(DatabaseService.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simple Note',
      theme: ThemeData(
        useMaterial3: true,
        // primarySwatch: Colors.blue,
      ),
      routeInformationParser: AppRoutes().goRouter.routeInformationParser,
      routeInformationProvider: AppRoutes().goRouter.routeInformationProvider,
      routerDelegate: AppRoutes().goRouter.routerDelegate,
    );
  }
}
