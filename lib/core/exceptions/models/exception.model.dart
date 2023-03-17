import 'package:json_annotation/json_annotation.dart';

import 'user_message.model.dart';

part 'exception.model.g.dart';

@JsonSerializable(createToJson: false)
class CustomException implements Exception {
  late String? confirmMessageId;
  late DateTime? creationDateTime;
  late DateTime? requestReceiptDateTime;
  late int? statusCode;
  @JsonKey(defaultValue: <UserMessage>[])
  late List<UserMessage> userMessages;
  late String? error;
  @JsonKey(name: 'error_description')
  late String? errorDescription;

  CustomException({CustomException? ex}) {
    this.confirmMessageId = ex?.confirmMessageId;
    this.creationDateTime = ex?.creationDateTime;
    this.requestReceiptDateTime = ex?.requestReceiptDateTime;
    this.userMessages = ex?.userMessages ?? [];
    this.error = ex?.error;
    this.errorDescription = ex?.errorDescription;
  }

  factory CustomException.fromJson(Map<String, dynamic> json) =>
      _$CustomExceptionFromJson(json);

  String get message => this.userMessages.map((e) => e.messageTxt).join('\n');
}
