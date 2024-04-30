class Categories {
  bool? current;
  String? image;
  String? name;
  int? id;

  Categories({this.current, this.image, this.name, this.id});

  Categories.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    image = json['image'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    data['image'] = image;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
