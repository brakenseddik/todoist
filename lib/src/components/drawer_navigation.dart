import 'package:flutter/material.dart';
import 'package:todoist/src/views/categories_screen.dart';
import 'package:todoist/src/views/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  radius: 50.0,
                  child: Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                ),
                accountName: Text('Todoist'),
                accountEmail: Text('TODO mobile application.')),
            ListTile(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
              title: Text('HomePage'),
              leading: Icon(Icons.home),
            ),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
              title: Text('Categories'),
              leading: Icon(Icons.list),
            ),
          ],
        ),
      ),
    );
  }
}
