class Category {
  int id;
  String name, description;

  categoryMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}
