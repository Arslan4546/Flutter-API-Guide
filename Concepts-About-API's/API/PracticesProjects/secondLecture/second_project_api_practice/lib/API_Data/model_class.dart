// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserAPIModel {
  final int id;
  final String name;
  final String companyName;
  final String location;
  UserAPIModel({
    required this.id,
    required this.name,
    required this.companyName,
    required this.location,
  });

  UserAPIModel copyWith({
    int? id,
    String? name,
    String? companyName,
    String? location,
  }) {
    return UserAPIModel(
      id: id ?? this.id,
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'name': name,
      'companyName': companyName,
      'location': location,
    };
  }

  factory UserAPIModel.fromMap(Map<String, dynamic> map) {
    final location = map['address'];
    final company = map['company'];

    return UserAPIModel(
      id: map["id"] ?? "",
      name: map['name'] ?? '',
      location: '${location['street']}, ${location['city']}',
      companyName: company['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAPIModel.fromJson(String source) =>
      UserAPIModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UerAPIModel(id: $id, name: $name, companyName: $companyName, location: $location)';
  }

  @override
  bool operator ==(covariant UserAPIModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.companyName == companyName &&
        other.location == location;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        companyName.hashCode ^
        location.hashCode;
  }
}
