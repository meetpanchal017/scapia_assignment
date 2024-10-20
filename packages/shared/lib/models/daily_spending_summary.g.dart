// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_spending_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailySpendingSummary _$DailySpendingSummaryFromJson(
        Map<String, dynamic> json) =>
    DailySpendingSummary(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailySpendingSummaryToJson(
        DailySpendingSummary instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'transactions': instance.transactions,
    };
