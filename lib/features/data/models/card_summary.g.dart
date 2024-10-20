// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardSummary _$CardSummaryFromJson(Map<String, dynamic> json) => CardSummary(
      userId: json['user_id'] as String?,
      creditCardLimit: (json['credit_card_limit'] as num?)?.toInt(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => DailySpendingSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardSummaryToJson(CardSummary instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'credit_card_limit': instance.creditCardLimit,
      'transactions': instance.transactions,
    };
