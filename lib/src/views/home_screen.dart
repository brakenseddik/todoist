import 'package:flutter/material.dart';
import 'package:todoist/src/components/drawer_navigation.dart';
import 'package:todoist/src/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todoist',
          style: kAppBarTitle,
        ),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
