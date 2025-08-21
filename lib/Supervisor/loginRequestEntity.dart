class LoginRequestEntity {
  int? type;
  int? online;
  String? email;
  String? description;
  String? phone;
  String? avatar;
  String? open_id;
  String? name;

  LoginRequestEntity({
    this.email,
    this.type,
    this.description,
    this.open_id,
    this.avatar,
    this.online,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "description": description,
        "online": online,
        "open_id": open_id,
        "avatar": avatar,
        "email": email,
        "phone": phone,
      };
}
