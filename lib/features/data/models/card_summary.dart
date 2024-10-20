import 'package:json_annotation/json_annotation.dart';
import 'package:shared/models/daily_spending_summary.dart';

part 'card_summary.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class CardSummary {
  final String? userId;
  final int? creditCardLimit;
  final List<DailySpendingSummary>? transactions;

  CardSummary({
    this.userId,
    this.creditCardLimit,
    this.transactions,
  });

  factory CardSummary.fromJson(Map<String, dynamic> json) =>
      _$CardSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$CardSummaryToJson(this);
}
