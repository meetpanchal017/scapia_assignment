// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      transactionId: (json['transaction_id'] as num?)?.toInt(),
      merchantName: json['merchant_name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      transactionType: $enumDecodeNullable(
          _$TransactionTypeEnumMap, json['transaction_type']),
      category:
          $enumDecodeNullable(_$SpendingCategoryEnumMap, json['category']),
      status: json['status'] as String?,
      description: json['description'] as String?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'transaction_id': instance.transactionId,
      'merchant_name': instance.merchantName,
      'amount': instance.amount,
      'transaction_type': _$TransactionTypeEnumMap[instance.transactionType],
      'category': _$SpendingCategoryEnumMap[instance.category],
      'status': instance.status,
      'description': instance.description,
      'currency': instance.currency,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.credit: 'credit',
  TransactionType.debit: 'debit',
};

const _$SpendingCategoryEnumMap = {
  SpendingCategory.essentials: 'essentials',
  SpendingCategory.diningEntertainment: 'diningEntertainment',
  SpendingCategory.travel: 'travel',
  SpendingCategory.shopping: 'shopping',
  SpendingCategory.subscriptions: 'subscriptions',
  SpendingCategory.healthFitness: 'healthFitness',
  SpendingCategory.transportation: 'transportation',
  SpendingCategory.education: 'education',
  SpendingCategory.homeUtilities: 'homeUtilities',
  SpendingCategory.other: 'other',
};
