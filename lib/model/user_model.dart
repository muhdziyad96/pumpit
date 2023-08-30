class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? gender;
  String? image;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.image,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        gender: json['gender'],
        image: json['image'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'gender': gender,
      'image': image,
    };
  }
}
