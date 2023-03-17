import 'package:json_annotation/json_annotation.dart';

part 'user_message.model.g.dart';

@JsonSerializable(createToJson: false)
class UserMessage {
  late String codeValue;
  late String messageTxt;
  late String debugMessage;
  late String action;
  late String field;

  UserMessage();

  factory UserMessage.fromJson(Map<String, dynamic> json) => _$UserMessageFromJson(json);
}
