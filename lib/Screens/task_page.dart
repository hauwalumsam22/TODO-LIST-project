import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  double? _deviceHeight, _deviceWidth;
  String? content;
  Box? _box;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          "Daily Planner",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        toolbarHeight: _deviceHeight! * 0.1,
        backgroundColor: Colors.pink.shade100,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        centerTitle: true,
      ),
      body: _taskWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: displayTaskPop,
        backgroundColor: Colors.pink.shade100,
        elevation: 8,
        child: const Icon(Icons.add, size: 28, color: Colors.black),
      ),
    );
  }

  Widget _taskWidget() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _box = snapshot.data;
          return const Center(child: Text("PEACE HAUWA"));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void displayTaskPop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.pink.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Add a ToDo"),
          content: TextField(
            onSubmitted: (value) {
              setState(() {
                print(value);
                Navigator.pop(context);
              });
            },

            onChanged: (value) {
              setState(() {
                content = value;

                print(value);
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter your task here',
            ),
          ),
        );
      },
    );
  }
}
