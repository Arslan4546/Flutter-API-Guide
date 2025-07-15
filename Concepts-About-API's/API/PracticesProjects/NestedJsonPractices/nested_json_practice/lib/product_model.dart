// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

// product_model.dart
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<String> images;
  final double height;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
    required this.height,
    required this.reviews,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    double? rating,
    List<String>? images,
    double? height,
    List<Review>? reviews,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      images: images ?? this.images,
      height: height ?? this.height,
      reviews: reviews ?? this.reviews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'images': images,
      'height': height,
      'reviews': reviews.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] ?? 0.0,
      rating: map['rating'] ?? 0.0,
      images: List<String>.from((map['images'] as List<dynamic>)),
      height: map["dimensions"]['height'] ?? 0.0,
      reviews:
          map['reviews'] != null
              ? List<Review>.from(
                (map['reviews'] as List<dynamic>).map(
                  (x) => Review.fromMap(x as Map<String, dynamic>),
                ),
              )
              : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, rating: $rating, images: $images, height: $height, reviews: $reviews)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.rating == rating &&
        listEquals(other.images, images) &&
        other.height == height &&
        listEquals(other.reviews, reviews);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        images.hashCode ^
        height.hashCode ^
        reviews.hashCode;
  }
}

class Review {
  final int rating;
  final String comment;
  final String reviewerName;

  Review({
    required this.rating,
    required this.comment,
    required this.reviewerName,
  });

  Review copyWith({int? rating, String? comment, String? reviewerName}) {
    return Review(
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      reviewerName: reviewerName ?? this.reviewerName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'comment': comment,
      'reviewerName': reviewerName,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      rating: map['rating'] as int,
      comment: map['comment'] as String,
      reviewerName: map['reviewerName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Review(rating: $rating, comment: $comment, reviewerName: $reviewerName)';

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.rating == rating &&
        other.comment == comment &&
        other.reviewerName == reviewerName;
  }

  @override
  int get hashCode =>
      rating.hashCode ^ comment.hashCode ^ reviewerName.hashCode;
}
