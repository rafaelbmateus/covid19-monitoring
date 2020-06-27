class User {
  final String uid;

  User({ this.uid });
}

class UserData {
  final String uid;
  final String email;
  final String name;
  final String cpf;
  final String phone;

  UserData({ this.uid, this.email, this.name, this.cpf, this.phone });

  UserData.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        cpf = json['cpf'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'name': name,
    'cpf': cpf,
    'phone': phone,
  };
}
