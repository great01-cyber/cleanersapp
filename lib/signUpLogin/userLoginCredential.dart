import 'package:flutter/foundation.dart';

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

class userProfile {
  String? access_token;
  String? token;
  String? name;
  String? description;
  String? avatar;
  String? online;
  String? type;

  userProfile({
    this.access_token,
    this.name,
    this.description,
    this.type,
    this.online,
    this.avatar,
    this.token,
  });

  factory userProfile.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return userProfile(
      access_token: json['access_token'] ?? "",
      token: json['token'] ?? "",
      name: json['name'] ?? "Guest",
      description: json['description'] ?? "",
      avatar: json['avatar'] ?? "uploads/default.png",
      online: json['online'] ?? false,
      type: json['type'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': access_token,
      'token': token,
      'name': name,
      'description': description,
      'avatar': avatar,
      'online': online,
      'type': type,
    };
  }
}

class userLoginResponseEntity {
  int? code;
  String? msg;
  userProfile? data;

  userLoginResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory userLoginResponseEntity.fromJson(Map<String, dynamic> json) {
    return userLoginResponseEntity(
      code: json['code'],
      msg: json['msg'],
      data: json['data'] != null ? userProfile.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'data': data?.toJson(),
    };
  }
}
