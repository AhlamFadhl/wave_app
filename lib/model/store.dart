import 'package:wave_app/model/review.dart';

class Store {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? email;
  String? mobile;
  String? detail;
  Review? review;
  int? staffCount;
  int? branchesCount;
  bool? hasFavorite;
  List<String>? banners;

  List<String>? stories;
  List<Socials>? socials;
  List<Services>? services;
  List<Branches>? branches;
  List? feedbacks;
  List<Departments>? departments;

  Store({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.email,
    this.mobile,
    this.detail,
    this.review,
    this.staffCount,
    this.branchesCount,
    this.hasFavorite,
    this.banners,
    this.stories,
    this.socials,
    this.services,
    this.branches,
    this.feedbacks,
    this.departments,
  });

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json.containsKey('email') ? json['email'] : '';
    mobile = json.containsKey('mobile') ? json['mobile'] : '';
    detail = json.containsKey('detail') ? json['detail'] : '';
    slug = json['slug'];
    image = json['image'];
    review =
        json['review'] != null ? new Review.fromJson(json['review']) : null;
    staffCount = json['staff_count'];
    branchesCount = json['branches_count'];
    hasFavorite = json['has_favorite'];
    banners =
        json.containsKey('banners') ? json['banners'].cast<String>() : null;
    if (json['socials'] != null) {
      socials = <Socials>[];
      json['socials'].forEach((v) {
        socials!.add(new Socials.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    //feedbacks

    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(new Departments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['detail'] = this.detail;
    data['slug'] = this.slug;
    data['image'] = this.image;
    if (this.review != null) {
      data['review'] = this.review!.toJson();
    }
    data['staff_count'] = this.staffCount;
    data['branches_count'] = this.branchesCount;
    data['has_favorite'] = this.hasFavorite;
    data['banners'] = this.banners;
    data['stories'] = this.stories;
    if (this.socials != null) {
      data['socials'] = this.socials!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    //feedbacks

    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Socials {
  String? link;
  String? name;
  String? icon;

  Socials({this.link, this.name, this.icon});

  Socials.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}

class Services {
  List<Branches>? branches;
  List<int>? groupsIds;
  String? duration;
  String? type;
  String? price;
  String? details;
  String? image;
  int? id;
  String? name;

  Services(
      {this.branches,
      this.groupsIds,
      this.duration,
      this.type,
      this.price,
      this.details,
      this.image,
      this.id,
      this.name});

  Services.fromJson(Map<String, dynamic> json) {
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    groupsIds = json['groups_ids'].cast<int>();
    duration = json['duration'];
    type = json['type'];
    price = json['price'];
    details = json['details'];
    image = json['image'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    data['groups_ids'] = this.groupsIds;
    data['duration'] = this.duration;
    data['type'] = this.type;
    data['price'] = this.price;
    data['details'] = this.details;
    data['image'] = this.image;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Branches {
  String? longitude;
  String? latitude;
  bool? isMain;
  String? address;
  int? id;
  String? name;

  Branches(
      {this.longitude,
      this.latitude,
      this.isMain,
      this.address,
      this.id,
      this.name});

  Branches.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
    isMain = json['is_main'];
    address = json['address'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['is_main'] = this.isMain;
    data['address'] = this.address;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Departments {
  String? image;
  int? id;
  String? name;
  bool? isSelected;

  Departments({this.image, this.id, this.name, this.isSelected = false});

  Departments.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    name = json['name'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
