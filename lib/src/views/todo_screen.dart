import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoist/src/components/todo_field.dart';
import 'package:todoist/src/constants.dart';
import 'package:todoist/src/services/category_service.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  List<DropdownMenuItem> _categories = List<DropdownMenuItem>();
  var _selectedValue;
  DateTime _dateTime = DateTime.now();

  _showTimeDialogue() async {
    var _pickDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2299));
    if (_pickDate != null) {
      setState(() {
        _dateTime = _pickDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_pickDate);
      });
    }
  }

  _loadCategories() async {
    var _service = CategoryService();
    var categories = await _service.getCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: kAppBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25),
          child: Center(
            child: Column(
              children: [
                buildTextField('Task title', Icons.create, _titleController),
                SizedBox(
                  height: 10.0,
                ),
                buildTextField('Task description', Icons.description,
                    _descriptionController),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      prefixIcon: IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            _showTimeDialogue();
                          }),
                      hintText: 'YYYY MM DD'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DropdownButtonFormField(
                  value: _selectedValue,
                  hint: Text('Category'),
                  items: _categories,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.category),
                    border:
                        new OutlineInputBorder(borderSide: new BorderSide()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {},
                    color: blue,
                    child: Text(
                      'Save ToDo',
                      style: TextStyle(color: white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
