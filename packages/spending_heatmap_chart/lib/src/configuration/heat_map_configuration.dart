import 'package:flutter/material.dart';
import 'package:shared/models/monthly_spending_summary.dart';
import 'package:spending_heatmap_chart/src/configuration/spending_threshold.dart';
import 'package:spending_heatmap_chart/src/constants/enums/cell_type.dart';

class HeatMapChartConfiguration {
  final EdgeInsets padding;

  // Cell configuration
  final double cellAspectRatio;
  final double weekHeaderCellAspectRatio;
  final Color cellColor;
  final double cellVerticalSpacing;
  final double cellHorizontalSpacing;
  final double maximumSpendingLimit;
  final List<SpendingThreshold> spendingThreshold;
  final BoxDecoration Function(CellType type)? cellDecoration;

  // Text styles for cell display and headers
  final TextStyle? cellDisplayDateTextStyle;
  final TextStyle? weekHeaderTextStyle;

  // Legend configuration
  final double legendSize;
  final double legendSpacing;

  // Credit indicator configuration
  final bool showCreditIndicator;
  final Color creditIndicatorColor;
  final double creditIndicatorSize;
  final Alignment creditIndicatorAlignment;
  final EdgeInsets creditIndicatorPadding;

  final Widget Function(MonthlySpendingSummary summary)? monthHeaderBuilder;
  final Widget Function(List<SpendingThreshold> spendingThresholds)? legendsBuilder;

  /// Creates a configuration for the heat map chart.
  HeatMapChartConfiguration({
    this.padding = EdgeInsets.zero,
    this.cellAspectRatio = 1,
    this.weekHeaderCellAspectRatio = 1.5,
    this.cellColor = Colors.deepOrange,
    this.cellHorizontalSpacing = 2,
    this.cellVerticalSpacing = 2,
    this.cellDisplayDateTextStyle,
    this.weekHeaderTextStyle,
    required this.maximumSpendingLimit,
    List<SpendingThreshold>? spendingThreshold,
    this.legendSize = 16,
    this.legendSpacing = 12,
    this.showCreditIndicator = true,
    this.creditIndicatorColor = Colors.green,
    this.creditIndicatorSize = 6,
    this.creditIndicatorAlignment = Alignment.topRight,
    EdgeInsets? creditIndicatorPadding,
    this.monthHeaderBuilder,
    this.legendsBuilder,
    this.cellDecoration,
  })  : spendingThreshold =
            spendingThreshold ?? SpendingThreshold.defaultThreshold,
        creditIndicatorPadding =
            creditIndicatorPadding ?? const EdgeInsets.all(8) {
    // Validations
    assert(cellAspectRatio > 0, 'Cell aspect ratio must be greater than 0.');
    assert(weekHeaderCellAspectRatio > 0,
        'Week header cell aspect ratio must be greater than 0.');
    assert(cellVerticalSpacing >= 0,
        'Cell vertical spacing must be non-negative.');
    assert(cellHorizontalSpacing >= 0,
        'Cell horizontal spacing must be non-negative.');
    assert(maximumSpendingLimit > 0,
        'Maximum spending limit must be greater than 0.');
    assert(legendSize > 0, 'Legend size must be greater than 0.');
    assert(legendSpacing >= 0, 'Legend spacing must be non-negative.');
    assert(creditIndicatorSize > 0,
        'Credit indicator size must be greater than 0.');

    // Ensure that all percentages in spendingThreshold are unique
    assert(
      _arePercentagesUnique(spendingThreshold ?? []),
      'Spending threshold percentages must be unique.',
    );
  }

  // Helper method to check if the percentages in the spendingThreshold list are unique
  bool _arePercentagesUnique(List<SpendingThreshold> spendingThresholds) {
    final percentageSet = <int>{};
    for (var threshold in spendingThresholds) {
      if (!percentageSet.add(threshold.percentage)) {
        return false; // Duplicate found
      }
    }
    return true;
  }
}
