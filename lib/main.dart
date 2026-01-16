import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart ';
import 'package:daily_planner/Screens/task_page.dart';
import 'package:flutter/material.dart';


void main() async {
  await Hive.initFlutter("hive_box");
  runApp(const Todoapp());
}

class Todoapp extends StatelessWidget {
  const Todoapp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade100),
      ),
      home: TaskPage(),
    );
  }
}
