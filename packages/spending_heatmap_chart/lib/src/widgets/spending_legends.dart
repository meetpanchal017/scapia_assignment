import 'package:flutter/material.dart';
import 'package:shared/extensions/context_extension.dart';
import 'package:shared/extensions/double_extension.dart';
import 'package:spending_heatmap_chart/spending_heatmap_chart.dart';
import '../configuration/configuration_provider.dart';

class SpendingLegends extends StatelessWidget {
  final HeatMapChartConfiguration config;

  const SpendingLegends({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return ConfigurationProvider(
      config: config,
      child: Builder(
        builder: (context) {
          final config = ConfigurationProvider.of(context);
          final spacing = config.legendSpacing;

          return config.legendsBuilder?.call(config.spendingThreshold) ??
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Wrap(
                      runSpacing: spacing,
                      spacing: spacing,
                      children: [
                        // Build legends for each threshold
                        ...config.spendingThreshold.map((threshold) {
                          return _Legend(
                            color:
                                config.cellColor.withOpacity(threshold.opacity),
                            label: 'Up to ${threshold.percentage}%',
                          );
                        }),
                        // Legend for max limit
                        _Legend(
                          color: config.cellColor,
                          label: 'More',
                        ),
                        if (config.showCreditIndicator) const _CreditLegend(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        'Your credit card limit: ${config.maximumSpendingLimit.format}',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final config = ConfigurationProvider.of(context);

    return Column(
      children: [
        Container(
          height: config.legendSize,
          width: config.legendSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _CreditLegend extends StatelessWidget {
  const _CreditLegend();

  @override
  Widget build(BuildContext context) {
    final config = ConfigurationProvider.of(context);

    return Column(
      children: [
        SizedBox(
          height: config.legendSize,
          child: CircleAvatar(
            radius: config.creditIndicatorSize / 2,
            backgroundColor: config.creditIndicatorColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Credit',
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}
