// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exception.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomException _$CustomExceptionFromJson(Map<String, dynamic> json) =>
    CustomException()
      ..confirmMessageId = json['confirmMessageId'] as String?
      ..creationDateTime = json['creationDateTime'] == null
          ? null
          : DateTime.parse(json['creationDateTime'] as String)
      ..requestReceiptDateTime = json['requestReceiptDateTime'] == null
          ? null
          : DateTime.parse(json['requestReceiptDateTime'] as String)
      ..statusCode = json['statusCode'] as int?
      ..userMessages = (json['userMessages'] as List<dynamic>?)
              ?.map((e) => UserMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []
      ..error = json['error'] as String?
      ..errorDescription = json['error_description'] as String?;
