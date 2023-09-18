class ViewUser {
  String? name;
  String? email;
  String? dob;
  String? country;
  String? state;
  String? city;

  ViewUser(
      {this.name, this.email, this.dob, this.country, this.state, this.city});

  ViewUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    dob = json['dob'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['dob'] = dob;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    return data;
  }
}
