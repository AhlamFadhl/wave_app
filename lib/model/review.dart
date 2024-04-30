// ignore_for_file: public_member_api_docs, sort_constructors_first
class Review {
  int? rating;
  int? count;
  String? name;
  String? note;
  String? datetime;
  int? usr;

  Review({
    this.rating,
    this.count,
    required this.name,
    required this.note,
    required this.datetime,
    required this.usr,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'rating': rating,
      'count': count,
      'name': name,
      'note': note,
      'datetime': datetime,
      'usr': usr,
    };
  }

  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      rating: map['rating'] != null ? map['rating'] as int : null,
      count: map['count'] != null ? map['count'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      datetime: map['datetime'] != null ? map['datetime'] as String : null,
      usr: map['usr'] != null ? map['usr'] as int : null,
    );
  }
}
