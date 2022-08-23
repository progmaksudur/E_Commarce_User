import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/model/address_model.dart';

class UserModel {
  String uid;
  String? name;
  String email;
  String? mobile;
  String? image;
  AddressModel? address;
  Timestamp userCreationTime;
  String? deviceToken;

  UserModel({
    required this.uid,
    this.name,
    required this.email,
    this.mobile,
    this.image,
    this.address,
    required this.userCreationTime,
    this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "uid": uid,
      "name": name,
      "mobile": mobile,
      "email": email,
      "image": image,
      "address": address,
      "deviceToken": deviceToken,
      "userCreationTime": userCreationTime
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map["uid"],
    name: map["name"],
    mobile: map["mobile"],
    email: map["email"],
    image: map["image"],
    address: map["address"],
    deviceToken: map["deviceToken"],
    userCreationTime: map['userCreationTime'],
  );
}
