import 'package:flutter/material.dart';

enum FlavorEnvironment { DEV, PROD, STAGING }

class FlavorConfig {

  factory FlavorConfig({
    required final Map<String, dynamic> variables, FlavorEnvironment environment = FlavorEnvironment.PROD,
    Color color = Colors.red,
    BannerLocation location = BannerLocation.topStart,
    String name = '',
  }) {
    _instance ??= FlavorConfig._internal(
      environment,
      color,
      variables,
      location,
      name,
    );
    return _instance!;
  }

  FlavorConfig._internal(
    this.environment,
    this.color,
    this.variables,
    this.location,
    this.name,
  );
  final FlavorEnvironment environment;
  final Color color;
  final Map<String, dynamic> variables;
  final BannerLocation location;
  final String name;
  static FlavorConfig? _instance;
  static FlavorConfig? get instance => _instance;

  @override
  String toString() {
    return 'FlavorConfig{environment: $environment, color: $color, variables: $variables, location: $location, name: $name}';
  }
}
