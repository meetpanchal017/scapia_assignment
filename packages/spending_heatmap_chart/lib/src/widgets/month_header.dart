part of 'monthly_spending_heat_chart.dart';

class MonthHeader extends StatelessWidget {
  final MonthlySpendingSummary summary;

  const MonthHeader({
    super.key,
    required this.summary,
  });

  double _getRemainingLimit(double current, double total) {
    return total - current;
  }

  @override
  Widget build(BuildContext context) {
    final config = ConfigurationProvider.of(context);
    final month = DateTime(summary.year ?? 0, summary.month ?? 0);
    final bool isCurrentMonth = month.isCurrentMonth;

    return config.monthHeaderBuilder?.call(summary) ??
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display month name, using configured or default style
              Text(
                DayMonthUtils.getMonthNameByNumber(summary.month ?? 0),
                style: config.weekHeaderTextStyle ??
                    context.textTheme.headlineSmall,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Display total spending
                  Text(
                    summary.totalSpending.format,
                    style: config.weekHeaderTextStyle ??
                        context.textTheme.headlineSmall,
                  ),

                  // Display remaining limit only for the current month
                  if (isCurrentMonth)
                    Text(
                      '(Remaining: ${_getRemainingLimit(
                        summary.totalSpending,
                        config.maximumSpendingLimit,
                      ).format})',
                      style: context.textTheme.bodyMedium,
                    ),
                ],
              )
            ],
          ),
        );
  }
}
