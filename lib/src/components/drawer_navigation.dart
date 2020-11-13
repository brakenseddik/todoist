import 'package:flutter/material.dart';
import 'package:todoist/src/services/category_service.dart';
import 'package:todoist/src/views/categories_screen.dart';
import 'package:todoist/src/views/home_screen.dart';
import 'package:todoist/src/views/todosByCategory_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>();
  CategoryService _service = CategoryService();

  getAllCategories() async {
    var categories = await _service.getCategories();
    categories.forEach((category) {
      setState(() {
        _categoryList.add(ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskByCategory(
                          category: category['name'],
                        )));
          },
          title: Text(category['name']),
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

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
            Divider(),
            Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}
