import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared/constants/enums/transaction_type.dart';
import 'package:shared/extensions/context_extension.dart';
import 'package:shared/extensions/date_time_extension.dart';
import 'package:shared/extensions/double_extension.dart';
import 'package:shared/models/daily_spending_summary.dart';

part '../widgets/transaction_prefix.dart';

class SpendingDetailsScreen extends StatefulWidget {

  const SpendingDetailsScreen({
    required this.spendingSummary, super.key,
  });
  final DailySpendingSummary spendingSummary;

  @override
  State<SpendingDetailsScreen> createState() => _SpendingDetailsScreenState();
}

class _SpendingDetailsScreenState extends State<SpendingDetailsScreen> {
  IconData getIconByTransactionType(TransactionType? type) {
    if (type == TransactionType.credit) {
      return Icons.arrow_downward_outlined;
    } else {
      return Icons.arrow_upward_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = widget.spendingSummary;
    final transactions = summary.transactions ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          summary.date?.getFormattedDateByMonth ?? '',
        ),
      ),
      body: transactions.isNotEmpty
          ? SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Total spent: ${summary.totalSpending(false).format}',
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: transactions.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return ListTile(
                          title: Text(
                            transaction.amount?.format ?? '',
                            style: context.textTheme.titleLarge,
                          ),
                          subtitle: Text(transaction.description.toString()),
                          leading: Icon(
                            transaction.category?.icon,
                            size: 18,
                          ),
                          trailing: _TransactionPrefix(
                              type: transaction.transactionType,),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child:
                  Text('''Looks like you haven't made any my_spending :('''),
            ),
    );
  }
}
