import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:myapp/configuration/network_config.model.dart';
import 'package:myapp/configuration/oauth_config.model.dart';

part 'app_config.model.g.dart';

/// App Configuration model serves a Repository for Application Specific Confguration.
/// - This includes the OAuth Configuration (Base Url, Client Secrets etc).
/// - Network Configuration has the connection timeout and receive timeouts related info.
@JsonSerializable(createToJson: false)
class AppConfiguration {
  late OAuthConfig oAuthConfig;
  late NetworkConfiguration networkConfig;

  AppConfiguration();

  Future<void> initConfiguration() async {
    var configJson = await rootBundle.loadString('assets/config/config.json');
    var configMap = jsonDecode(configJson);
    oAuthConfig = OAuthConfig.fromJson(configMap['oAuthConfig']);
    networkConfig = NetworkConfiguration.fromJson(configMap['networkConfig']);
  }

  factory AppConfiguration.fromJson(Map<String, dynamic> map) =>
      _$AppConfigurationFromJson(map);
}
