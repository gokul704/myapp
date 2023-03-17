import 'package:json_annotation/json_annotation.dart';

part 'network_config.model.g.dart';

@JsonSerializable()
class NetworkConfiguration {
  int connectionTimeout;
  int receiveTimeout;

  NetworkConfiguration({
    required this.connectionTimeout,
    required this.receiveTimeout,
  });

  factory NetworkConfiguration.fromJson(Map<String, dynamic> map) => _$NetworkConfigurationFromJson(map);

  Map<String, dynamic> toJson() => _$NetworkConfigurationToJson(this);
}
