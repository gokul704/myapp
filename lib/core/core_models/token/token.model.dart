// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'token.model.g.dart';

@JsonSerializable()
class Token {
  String access_token;
  String token_type;
  int expires_in;
  Token({
    required this.access_token,
    required this.token_type,
    required this.expires_in,
  });

  factory Token.fromJson(Map<String, dynamic> data) => _$TokenFromJson(data);

  Map<String, dynamic> toMap() => _$TokenToJson(this);
}
