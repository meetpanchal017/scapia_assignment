import 'package:json_annotation/json_annotation.dart';
import 'package:shared/models/transaction.dart';

import '../constants/enums/transaction_type.dart';

part 'daily_spending_summary.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class DailySpendingSummary {
  final DateTime? date;
  final List<Transaction>? transactions;

  const DailySpendingSummary({
    this.date,
    this.transactions,
  });

  double totalSpending(bool adjustCredit) {
    double sum = 0;
    transactions?.forEach(
      (t) {
        if (t.transactionType == TransactionType.debit) {
          sum += t.amount ?? 0;
        } else if (t.transactionType == TransactionType.credit &&
            adjustCredit) {
          sum -= t.amount ?? 0;
        }
      },
    );
    return sum;
  }

  bool get anyCredit {
    return transactions?.any(
          (element) => element.transactionType == TransactionType.credit,
        ) ??
        false;
  }

  factory DailySpendingSummary.fromJson(Map<String, dynamic> json) =>
      _$DailySpendingSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$DailySpendingSummaryToJson(this);
}
