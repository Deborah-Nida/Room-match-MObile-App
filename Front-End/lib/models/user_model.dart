class UserModel {
  final String email;
  final String password;
  final String? name;
  final String? phone;
  final String? gender;

  UserModel({
    required this.email,
    required this.password,
    this.name,
    this.phone,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      gender: json['gender'],
    );
  }
}
