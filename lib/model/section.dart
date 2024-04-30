class Section {
  int? id;
  String? name;
  String? image;
  bool? isLoading;

  Section({this.id, this.name, this.image, this.isLoading = false});

  Section.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    id = json['id'];
    isLoading = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
