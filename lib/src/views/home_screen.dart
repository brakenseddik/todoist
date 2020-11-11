import 'package:flutter/material.dart';
import 'package:todoist/src/components/drawer_navigation.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todoist',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
