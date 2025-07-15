// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final int id;
  final String title;
  final String name;
  final String image;
  ProductModel({
    required this.id,
    required this.title,
    required this.name,
    required this.image,
  });

  ProductModel copyWith({int? id, String? title, String? name, String? image}) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'name': name,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? 'No Title',
      name: map['brand'] ?? 'Unknown Brand',
      image: map['thumbnail'] ?? '', // fallback if image is null
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, name: $name, image: $image)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.name == name &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ name.hashCode ^ image.hashCode;
  }
}
