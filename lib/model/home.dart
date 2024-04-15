import 'package:wave_app/model/category.dart';
import 'package:wave_app/model/store.dart';

class HomeModel {
  List<String>? sliders;
  List<Categories>? categories;
  List<Store>? recommend;
  List<Store>? stores;
  int? id;

  HomeModel(
      {this.sliders, this.categories, this.recommend, this.stores, this.id});

  HomeModel.fromJson(Map<String, dynamic> json) {
    sliders = (json['sliders'] as List<dynamic>).cast<String>();
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['recommend'] != null) {
      recommend = <Store>[];
      json['recommend'].forEach((v) {
        recommend!.add(Store.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Store>[];
      json['stores'].forEach((v) {
        stores!.add(Store.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sliders'] = this.sliders;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.recommend != null) {
      data['recommend'] = this.recommend!.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}
