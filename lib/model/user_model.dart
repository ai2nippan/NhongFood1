class UserModel {
  String? id;
  String? name;
  String? choosetype;
  String? user;
  String? password;

  UserModel({this.id, this.name, this.choosetype, this.user, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    choosetype = json['choosetype'];
    user = json['user'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['choosetype'] = this.choosetype;
    data['user'] = this.user;
    data['password'] = this.password;
    return data;
  }
}
