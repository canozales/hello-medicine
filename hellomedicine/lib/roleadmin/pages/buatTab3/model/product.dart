class Product {
  final String imagePath;
  final String name;
  final String kategori;
  final String harga;
  final String informasi;

  const Product({
    this.imagePath,
    this.name,
    this.kategori,
    this.harga,
    this.informasi,
  });

  Product copy({
    String imagePath,
    String name,
    String kategori,
    String harga,
    String informasi,
  }) =>
      Product(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        kategori: kategori ?? this.kategori,
        harga: harga ?? this.harga,
        informasi: informasi ?? this.informasi,
      );

  static Product fromJson(Map<String, dynamic> json) => Product(
        imagePath: json['imagePath'],
        name: json['name'],
        kategori: json['kategori'],
        harga: json['harga'],
        informasi: json['informasi'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'kategori': kategori,
        'harga': harga,
        'informasi': informasi,
      };
}
