class UserModel {
  String? userId;
  String? email;
  String? name;

  UserModel({this.userId, this.email, this.name});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map['userId'],
      email: map['email'],
      name: map['name'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
    };
  }
}
