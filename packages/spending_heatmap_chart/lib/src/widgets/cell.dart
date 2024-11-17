part of 'monthly_spending_heat_chart.dart';

class _Cell extends StatelessWidget {
  final DailySpendingSummary transaction;
  final VoidCallback onTap;
  final CellType type;
  final double opacity;

  const _Cell({
    required this.transaction,
    required this.onTap,
    required this.type,
    required this.opacity,
  });

  BoxDecoration _getDecoration(HeatMapChartConfiguration config) {
    final cellColor = config.cellColor.withOpacity(opacity);

    // Check if custom decoration is provided, apply it with color modification
    final customDecoration = config.cellDecoration?.call(type);
    if (customDecoration != null) {
      return customDecoration.copyWith(color: cellColor);
    }

    // Fallback to default decoration with condition for different cell types
    final baseDecoration = BoxDecoration(
      color: cellColor,
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
