import 'package:json_annotation/json_annotation.dart';

part 'oauth_config.model.g.dart';

@JsonSerializable()
class OAuthConfig {
  String baseUrl;

  OAuthConfig({
    required this.baseUrl,
  }) {
    this._loadAppConfig();
  }

  void _loadAppConfig() async {}

  Map<String, dynamic> toJson() => _$OAuthConfigToJson(this);
  factory OAuthConfig.fromJson(Map<String, dynamic> source) =>
      _$OAuthConfigFromJson(source);
}
