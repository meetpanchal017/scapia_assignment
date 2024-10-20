import 'package:flutter/material.dart';

import 'heat_map_configuration.dart';

class ConfigurationProvider extends InheritedWidget {
  final HeatMapChartConfiguration config;

  const ConfigurationProvider({
    super.key,
    required this.config,
    required super.child,
  });

  static HeatMapChartConfiguration of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ConfigurationProvider>();
    return provider?.config ??
        HeatMapChartConfiguration(maximumSpendingLimit: 100000);
  }

  @override
  bool updateShouldNotify(ConfigurationProvider oldWidget) {
    return oldWidget.config != config;
  }
}
