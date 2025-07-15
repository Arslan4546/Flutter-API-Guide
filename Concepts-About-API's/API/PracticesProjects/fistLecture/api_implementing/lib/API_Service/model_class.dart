class UserApi {
  final int id;
  final String name;
  final String email;
  final String companyName;
  final String address;

  UserApi({
    required this.name,
    required this.email,
    required this.companyName,
    required this.address,
    required this.id,
  });

  factory UserApi.fromMap(Map<String, dynamic> map) {
    final address = map['address'];
    final company = map['company'];

    return UserApi(
      id: map["id"] ?? "",
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: '${address['street']}, ${address['city']}',
      companyName: company['name'] ?? '',
    );
  }

  // other methods (copyWith, toMap, etc.) remain unchanged...
}
