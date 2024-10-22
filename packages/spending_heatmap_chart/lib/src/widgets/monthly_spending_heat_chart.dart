import 'package:flutter/material.dart';
import 'package:shared/extensions/context_extension.dart';
import 'package:shared/extensions/date_time_extension.dart';
import 'package:shared/extensions/double_extension.dart';
import 'package:shared/models/daily_spending_summary.dart';
import 'package:shared/models/monthly_spending_summary.dart';
import '../../spending_heatmap_chart.dart';
import '../configuration/heat_map_configuration.dart';
import '../configuration/configuration_provider.dart';
import '../constants/enums/cell_type.dart';
import '../utils/day_month_utils.dart';

part 'month_header.dart';

part 'week_header.dart';

part 'cell.dart';

class MonthlySpendingHeatChart extends StatelessWidget {
  final MonthlySpendingSummary monthlySummary;
  final HeatMapChartConfiguration config;
  final Function(DailySpendingSummary dailySummary)? onCellTapped;

  const MonthlySpendingHeatChart({
    super.key,
    required this.monthlySummary,
    required this.config,
    this.onCellTapped,
  });

  // Calculates the total number of days in the month.
  int _getTotalDaysInMonth() {
    final month = monthlySummary.month ?? 0;
    final year = monthlySummary.year ?? 0;
    return DateTime(year, month + 1, 0).day; // Get last day of the month.
  }

  // Calculates the initial day adjustment count for the grid.
  int _calculateInitialDayAdjustment() {
    final weekday =
        monthlySummary.dailySpendingSummary?.first.date?.weekday ?? 0;
    return weekday > 0 ? weekday - 1 : 0;
  }

  // Returns the total item count for the grid, including empty cells for missing days.
  int _calculateItemCount() {
    final totalDaysInMonth = _getTotalDaysInMonth();
    final adjustmentCount = _calculateInitialDayAdjustment();
    return totalDaysInMonth + adjustmentCount;
  }

  CellType _getCellType(DateTime date) {
    final DateTime now = DateTime.now();

    // Create DateTime objects with just year, month, and day (ignoring the time)
    final DateTime currentDate = DateTime(now.year, now.month, now.day);
    final DateTime inputDate = DateTime(date.year, date.month, date.day);

    if (inputDate.isBefore(currentDate)) {
      return CellType.past;
    } else if (inputDate.isAtSameMomentAs(currentDate)) {
      return CellType.current;
    } else {
      return CellType.upcoming;
    }
  }

  double normaliseOpacity(
    double current,
    double max,
    double min,
  ) {
    return (current - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    final dailySpendingSummary = monthlySummary.dailySpendingSummary ?? [];
    final adjustedCount = _calculateInitialDayAdjustment();
    final itemCount = _calculateItemCount();
    final totalDaysInMonth = _getTotalDaysInMonth();

    final maxTransactionOfTheMonth = monthlySummary.maxTransaction;
    final minTransactionOfTheMonth = monthlySummary.minTransaction;



    return ConfigurationProvider(
      config: config,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthHeader(summary: monthlySummary),
          const _WeekHeader(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: config.padding,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: config.cellAspectRatio,
              crossAxisSpacing: config.cellHorizontalSpacing,
              mainAxisSpacing: config.cellVerticalSpacing,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final effectiveIndex = index - adjustedCount;

              // Handle empty cells before the first day of the month
              if (effectiveIndex < 0 || effectiveIndex >= totalDaysInMonth) {
                return const SizedBox.shrink();
              }

              // Safely retrieve the daily transaction or provide an empty summary if missing
              final dailyTransaction =
                  effectiveIndex < dailySpendingSummary.length
                      ? dailySpendingSummary[effectiveIndex]
                      : DailySpendingSummary(
                          date: DateTime(
                            monthlySummary.year ?? 0,
                            monthlySummary.month ?? 0,
                            effectiveIndex + 1,
                          ),
                        );

              // Determine the type of cell based on the date
              final cellType = _getCellType(
                dailyTransaction.date ?? DateTime.now(),
              );
              final opacity = normaliseOpacity(
                dailyTransaction.totalSpending(false),
                maxTransactionOfTheMonth,
                minTransactionOfTheMonth,
              );

              return _Cell(
                transaction: dailyTransaction,
                onTap: () => onCellTapped?.call(dailyTransaction),
                type: cellType,
                opacity: opacity,
              );
            },
          ),
        ],
      ),
    );
  }
}
