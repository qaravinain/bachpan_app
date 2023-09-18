class UpdateUserModel {
  String? name;
  String? dob;
  String? country;
  String? state;
  String? city;

  UpdateUserModel({this.name, this.dob, this.country, this.state, this.city});

  UpdateUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dob = json['dob'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['dob'] = dob;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    return data;
  }
}
