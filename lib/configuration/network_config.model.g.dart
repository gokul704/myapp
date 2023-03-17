// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_config.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkConfiguration _$NetworkConfigurationFromJson(
        Map<String, dynamic> json) =>
    NetworkConfiguration(
      connectionTimeout: json['connectionTimeout'] as int,
      receiveTimeout: json['receiveTimeout'] as int,
    );

Map<String, dynamic> _$NetworkConfigurationToJson(
        NetworkConfiguration instance) =>
    <String, dynamic>{
      'connectionTimeout': instance.connectionTimeout,
      'receiveTimeout': instance.receiveTimeout,
    };
