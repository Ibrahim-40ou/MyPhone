class MyUser {
  late String userId;
  late String fullName;
  late String email;

  MyUser({
    required this.userId,
    required this.email,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
    };
  }

  static MyUser fromJson(Map<String, dynamic> data) {
    return MyUser(
      userId: data['userId'],
      email: data['email'],
      fullName: data['fullName'],
    );
  }
}
