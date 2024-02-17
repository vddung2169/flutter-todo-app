import 'package:flutter/material.dart';
import 'package:todo_app/config/config.dart';
import 'package:todo_app/screens/home_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: AppTheme.light,
    );
  }
}
