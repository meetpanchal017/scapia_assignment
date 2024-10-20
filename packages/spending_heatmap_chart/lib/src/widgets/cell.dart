part of 'monthly_spending_heat_chart.dart';

class _Cell extends StatelessWidget {
  final DailySpendingSummary transaction;
  final VoidCallback onTap;
  final CellType type;

  const _Cell({
    required this.transaction,
    required this.onTap,
    required this.type,
  });

  Color? _getColor(HeatMapChartConfiguration config) {
    final double percentage = _getPercentage(
      transaction.totalSpending(false),
      config.maximumSpendingLimit.toDouble(),
    );

    if (percentage > 0) {
      // Find the appropriate threshold for the current percentage

      // This will work as  validator of list is not sorted according the given percentage
      double lastComparedWith = 0;
      for (final threshold in config.spendingThreshold) {
        if (percentage < threshold.percentage &&
            lastComparedWith < threshold.percentage) {
          // If the current percentage is less than this threshold,
          // return the previous threshold color
          return config.cellColor.withOpacity(threshold.opacity);
        }
      }
      // If all thresholds are surpassed, return the highest threshold color
      return config.cellColor;
    }

    return null; // No spending or falls outside the threshold
  }

  double _getPercentage(double current, double total) {
    if (total == 0) return 0;
    return (current * 100) / total;
  }

  BoxDecoration _getDecoration(HeatMapChartConfiguration config) {
    final Color? cellColor = _getColor(config);

    // Check if custom decoration is provided, apply it with color modification
    final customDecoration = config.cellDecoration?.call(type);
    if (customDecoration != null) {
      return customDecoration.copyWith(color: cellColor);
    }

    // Fallback to default decoration with condition for different cell types
    final baseDecoration = BoxDecoration(
      color: cellColor ?? Colors.transparent,
      // Default to transparent if no spending
      borderRadius: BorderRadius.circular(8),
    );

    if (type == CellType.current) {
      return baseDecoration.copyWith(
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
      );
    } else if (type == CellType.upcoming) {
      return baseDecoration.copyWith(
        color: Colors.black.withOpacity(0.05),
      );
    }
    return baseDecoration;
  }

  @override
  Widget build(BuildContext context) {
    final config = ConfigurationProvider.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: _getDecoration(config),
            child: Text(
              transaction.date?.day.toString() ?? '',
              style: config.cellDisplayDateTextStyle ??
                  Theme.of(context).textTheme.labelMedium,
            ),
          ),
          if (transaction.anyCredit && config.showCreditIndicator)
            Align(
              alignment: config.creditIndicatorAlignment,
              child: Padding(
                padding: config.creditIndicatorPadding,
                child: _CreditIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _CreditIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = ConfigurationProvider.of(context);

    return CircleAvatar(
      radius: config.creditIndicatorSize / 2,
      backgroundColor: config.creditIndicatorColor,
    );
  }
}
