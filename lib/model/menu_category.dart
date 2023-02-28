class MenuCategory {
  String name;
  int id;

  MenuCategory({required this.name, required this.id});

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
