class CreateUser {
  String? name;
  String? email;
  String? password;
  String? dob;
  String? country;
  String? state;
  String? city;

  CreateUser(
      {this.name,
      this.email,
      this.password,
      this.dob,
      this.country,
      this.state,
      this.city});

  CreateUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    dob = json['dob'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['dob'] = dob;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    return data;
  }
}
