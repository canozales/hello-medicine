class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;

  const User({
    this.imagePath,
    this.name,
    this.email,
    this.about,
  });

  User copy({
    String imagePath,
    String name,
    String email,
    String about,
    bool isDarkMode,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
        about: about ?? this.about,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        name: json['name'],
        email: json['email'],
        about: json['about'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'email': email,
        'about': about,
      };
}
