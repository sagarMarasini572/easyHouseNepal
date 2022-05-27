class AllUsers {
  bool? success;
  List<String>? message;
  List<User>? user;

  AllUsers({this.success, this.message, this.user});

  AllUsers.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      user = <User>[];
      json['data'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (user != null) {
      data['data'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? userId;
  String? email;
  String? fullName;
  String? contact;
  String? role;
  String? profileImage;
  bool? isVerified;
  String? registerDate;

  User(
      {this.userId,
      this.email,
      this.fullName,
      this.contact,
      this.role,
      this.profileImage,
      this.isVerified,
      this.registerDate});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    fullName = json['full_name'];
    contact = json['contact'];
    role = json['role'];
    profileImage = json['profile_image'] ?? "";
    isVerified = json['is_verified'];
    registerDate = json['registration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    data['full_name'] = fullName;
    data['contact'] = contact;
    data['role'] = role;
    data['profile_image'] = profileImage;
    data['is_verified'] = isVerified;
    data['registration_date'] = registerDate;
    return data;
  }
}
