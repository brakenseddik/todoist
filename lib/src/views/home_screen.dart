import 'package:flutter/material.dart';
import 'package:todoist/src/components/drawer_navigation.dart';
import 'package:todoist/src/constants.dart';
import 'package:todoist/src/views/todo_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    );
  }
}
