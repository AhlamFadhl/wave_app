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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
