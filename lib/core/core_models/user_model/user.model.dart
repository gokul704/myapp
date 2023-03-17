// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserModel {
  int id;
  String name;
  String email;
  String? email_verified_at;
  String created_at;
  String updated_at;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.email_verified_at,
    required this.created_at,
    required this.updated_at,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
