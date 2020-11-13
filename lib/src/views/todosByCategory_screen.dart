import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoist/src/constants.dart';
import 'package:todoist/src/models/task.dart';
import 'package:todoist/src/services/task_service.dart';

class TaskByCategory extends StatefulWidget {
  final String category;

  TaskByCategory({this.category});
  @override
  _TaskByCategoryState createState() => _TaskByCategoryState();
}

class _TaskByCategoryState extends State<TaskByCategory> {
  TaskService _service = TaskService();
  List<Task> _tasks = List<Task>();

  getTasks() async {
    var tasks = await _service.getTaskByCategory(this.widget.category);
    tasks.forEach((task) {
      setState(() {
        var model = Task();
        model.title = task['title'];
        model.description = task['description'];
        model.category = task['category'];
        model.isFinished = task['isFinished'];
        model.id = task['id'];
        model.date = task['date'];
        _tasks.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: kAppBarTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: Text(_tasks[index].title),
              subtitle: Text(
                _tasks[index].description,
              ),
            ));
          },
        ),
      ),
    );
  }
}
