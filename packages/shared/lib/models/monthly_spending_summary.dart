import 'daily_spending_summary.dart';

class MonthlySpendingSummary {
  final int? month;
  final int? year;
  final List<DailySpendingSummary>? dailySpendingSummary;

  const MonthlySpendingSummary({
    this.month,
    this.year,
    this.dailySpendingSummary,
  });

  double get totalSpending {
    double sum = 0;
    dailySpendingSummary?.forEach(
      (element) => sum += element.totalSpending(true),
    );
    return sum;
  }

  double get maxTransaction {
    return dailySpendingSummary
            ?.map((element) => element.totalSpending(false))
            .reduce((curr, next) => curr > next ? curr : next) ??
        0;
  }

  double get minTransaction {
    // Get the min value using reduce
    return dailySpendingSummary
            ?.map((element) => element.totalSpending(false))
            .reduce((curr, next) => curr < next ? curr : next) ??
        0;
  }
}
