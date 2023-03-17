// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfiguration _$AppConfigurationFromJson(Map<String, dynamic> json) =>
    AppConfiguration()
      ..oAuthConfig =
          OAuthConfig.fromJson(json['oAuthConfig'] as Map<String, dynamic>)
      ..networkConfig = NetworkConfiguration.fromJson(
          json['networkConfig'] as Map<String, dynamic>);
