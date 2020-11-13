import 'package:flutter/material.dart';
import 'package:todoist/src/components/drawer_navigation.dart';
import 'package:todoist/src/constants.dart';
import 'package:todoist/src/models/task.dart';
import 'package:todoist/src/services/task_service.dart';
import 'package:todoist/src/views/todo_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskService _taskService = TaskService();
  List<Task> _tasksList = List<Task>();

  getAllTasks() async {
    _tasksList = List<Task>();
    var tasks = await _taskService.getTasks();
    tasks.forEach((task) {
      setState(() {
        var model = Task();
        model.title = task['title'];
        model.id = task['id'];
        model.description = task['description'];
        model.category = task['category'];
        model.date = task['date'];
        model.isFinished = task['isFinished'];
        _tasksList.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todoist',
          style: kAppBarTitle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ToDoScreen()));
          }),
      drawer: DrawerNavigation(),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              color: Colors.lightBlueAccent.withOpacity(0.5),
              child: ListTile(
                title: Text(_tasksList[index].title),
                subtitle: Text(_tasksList[index].description),
              ),
            );
          },
          itemCount: _tasksList.length,
        ),
      ),
    );
  }
}
