class User {
  final String phone;
  final String name;
  final String email;
  final String address;

  const User({
    this.phone,
    this.name,
    this.email,
    this.address,
  });

  User copy({
    String phone,
    String name,
    String email,
    String address,
  }) =>
      User(
        phone: phone ?? this.phone,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        phone: json['phone'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'name': name,
        'email': email,
        'address': address,
      };
}
