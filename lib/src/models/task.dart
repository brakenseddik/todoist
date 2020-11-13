class Task {
  String title, description, date, category;
  int id, isFinished;

  taskMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['isFinished'] = isFinished;
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['category'] = category;

    return map;
  }
}
