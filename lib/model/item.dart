import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? title;
  String? description;
  String? image;
  Timestamp? createdAt;

  Item(
      {required this.title,
      required this.description,
      required this.image,
      required this.createdAt});

  Item.fromJson(Map<String, Object?> json)
      : this(
            title: json['title']! as String,
            description: json['description']! as String,
            image: json['image']! as String,
            createdAt: json['createdAt']! as Timestamp);

  Item copyWith({
    String? title,
    String? description,
    String? image,
    Timestamp? createdAt,
  }) {
    return Item(
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt);
  }

  Map<String, Object?> tojson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'createdAt': createdAt
    };
  }
}
