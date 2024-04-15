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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['image'] = this.image;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
