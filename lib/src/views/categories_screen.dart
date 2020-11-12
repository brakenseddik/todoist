import 'package:flutter/material.dart';
import 'package:todoist/src/components/text_field.dart';
import 'package:todoist/src/constants.dart';
import 'package:todoist/src/models/category.dart';
import 'package:todoist/src/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextEditingController _NameController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  TextEditingController _EditNameController = TextEditingController();
  TextEditingController _EditDescriptionController = TextEditingController();
  CategoryService _categoryService = CategoryService();
  Category _category = Category();

  List<Category> _categoriesList = List<Category>();

  var category;

  getCategories() async {
    _categoriesList = [];
    var categories = await _categoryService.getCategories();
    categories.forEach((category) {
      setState(() {
        var model = Category();
        model.id = category['id'];
        model.name = category['name'];
        model.description = category['description'];
        _categoriesList.add(model);
      });
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
                  Field(
                    controller: _NameController,
                    hint: 'Category Name',
                  ),
                  Divider(
                    color: black,
                    thickness: 1,
                  ),
                  Field(
                    controller: _DescriptionController,
                    hint: 'Category Description',
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
                    if (result > 0) Navigator.pop(context);
                  },
                  child: Text('Save')),
            ],
          );
        });
  }

  _editCategoryDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: Text('Edit Category'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Field(
                    controller: _EditNameController,
                    hint: 'Edit Category Name',
                  ),
                  Divider(
                    color: black,
                    thickness: 1,
                  ),
                  Field(
                    controller: _EditDescriptionController,
                    hint: 'Edit Category Description',
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('Exit')),
              FlatButton(
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _EditNameController.text;
                    _category.description = _EditDescriptionController.text;
                    var result =
                        await _categoryService.updateCategory(_category);
                    print(result);
                    if (result > 0) {
                      Navigator.pop(context);
                      getCategories();
                      _showSnackBar(Text('Category updated successfully '));
                    }
                  },
                  child: Text('Update')),
            ],
          );
        });
  }

  _removeCategoryDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: Text('Edit Category'),
            content: Text('Are you sure you want to delete this category'),
            actions: [
              FlatButton(
                  color: Colors.green,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Exit',
                    style: TextStyle(color: white),
                  )),
              FlatButton(
                  color: Colors.red,
                  onPressed: () async {
                    _categoryService.removeCategory(categoryId);
                    Navigator.pop(context);
                    getCategories();
                    _showSnackBar(Text('Category deleted successfully'));
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: white),
                  )),
            ],
          );
        });
  }

  getCategoryById(BuildContext context, categoryId) async {
    category = await _categoryService.getCategoryById(categoryId);

    setState(() {
      _EditNameController.text = category[0]['name'];
      _EditDescriptionController.text = category[0]['description'];
    });

    _editCategoryDialog(context);
  }

  _showSnackBar(messagee) {
    var _snackBar = SnackBar(content: messagee);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(
          Icons.add,
          color: blue,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Categories',
          style: kAppBarTitle,
        ),
      ),
      body: ListView.builder(
        itemCount: _categoriesList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: Colors.white70,
            child: ListTile(
              leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    getCategoryById(context, _categoriesList[index].id);
                  }),
              title: Text(
                _categoriesList[index].name,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                _categoriesList[index].description,
                style: TextStyle(color: Colors.black),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _removeCategoryDialog(context, _categoriesList[index].id);
                  }),
            ),
          );
        },
      ),
    );
  }
}
