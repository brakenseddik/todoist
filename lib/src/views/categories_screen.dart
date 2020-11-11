import 'package:flutter/material.dart';
import 'package:todoist/src/models/category.dart';
import 'package:todoist/src/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController _NameController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  CategoryService _categoryService = CategoryService();
  Category _category = Category();

  List<Widget> _categoriesList = List<Widget>();

  getCategories() async {
    var categories = await _categoryService.getCategories();
    categories.forEach((category) {
      _categoriesList.add(Card(
        color: Colors.white70,
        child: ListTile(
          title: Text(
            category['name'],
            style: TextStyle(color: Colors.black),
          ),
        ),
      ));
    });
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: Text('Add Category'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _NameController,
                    decoration: InputDecoration(hintText: 'Category Name'),
                  ),
                  TextField(
                    controller: _DescriptionController,
                    decoration:
                        InputDecoration(hintText: 'Category Description'),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('Exit')),
              FlatButton(
                  onPressed: () async {
                    _category.name = _NameController.text;
                    _category.description = _DescriptionController.text;
                    var result = await _categoryService.saveCategory(_category);
                    print(result);
                    Navigator.pop(context);
                  },
                  child: Text('Save')),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: _categoriesList,
      ),
    );
  }
}
