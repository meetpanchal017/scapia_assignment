import 'package:json_annotation/json_annotation.dart';
import '../constants/enums/spending_category.dart';
import '../constants/enums/transaction_type.dart';

part 'transaction.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Transaction {
  final int? transactionId;
  final String? merchantName;
  final double? amount;
  final TransactionType? transactionType;
  final SpendingCategory? category;
  final String? status;
  final String? description;
  final String? currency;

  Transaction({
    this.transactionId,
    this.merchantName,
    this.amount,
    this.transactionType,
    this.category,
    this.status,
    this.description,
    this.currency,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
