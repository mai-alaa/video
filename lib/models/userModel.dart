class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? role;

  UserModel({this.name, this.email, this.phone, this.uId, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    role = json['role'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'role': role,
    };
  }
}
