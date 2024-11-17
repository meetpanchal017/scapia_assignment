import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia_assignment/core/constants/assets.dart';
import 'package:scapia_assignment/features/data/models/card_summary.dart';
import 'package:shared/shared.dart';

part 'card_summary_event.dart';
part 'card_summary_state.dart';

class CardSummaryBloc extends Bloc<CardSummaryEvent, CardSummaryState> {
  CardSummaryBloc() : super(CardSummaryInitial()) {
    on<GetAllTransactionsEvent>(_getAllTransactions);
  }

  Future<void> _getAllTransactions(
      GetAllTransactionsEvent event, Emitter<CardSummaryState> emit,) async {
    emit(CardSummaryLoadingState());
    try {
      // Load the data from the JSON
      final cardSummary = await _loadCardSummaryFromJson();
      // Process my_spending into monthly spending summaries
      final spendingSummary = _processTransactions(cardSummary);

      // Emit the success state with the computed spending summary
      emit(CardSummarySuccessState(
        creditCardLimit: cardSummary.creditCardLimit?.toDouble() ?? 0,
        spendingSummary: spendingSummary,
      ),);
    } on Exception catch (e) {
      emit(CardSummaryFailureState(error: e.toString()));
    }
  }

  Future<CardSummary> _loadCardSummaryFromJson() async {
    final jsonString = await rootBundle.loadString(Assets.mockTransactionJson);
    final jsonData = jsonDecode(jsonString);
    return CardSummary.fromJson(jsonData as Map<String, dynamic>);
  }

  List<MonthlySpendingSummary> _processTransactions(CardSummary cardSummary) {
    // Map where the key is the month (int) and the value is a MonthlySpendingSummary
    final monthlySummaries = <int, MonthlySpendingSummary>{};

    // Iterate over each transaction and group them by month
    cardSummary.transactions?.forEach((transaction) {
      final month = transaction.date?.month;
      if (month != null) {
        // Check if the month already exists in the map
        final monthlySummary = monthlySummaries.putIfAbsent(
          month,
          () => MonthlySpendingSummary(
            month: month,
            dailySpendingSummary: [],
            year: transaction.date?.year,
          ),
        );

        // Add the transaction to the corresponding month's summary
        monthlySummary.dailySpendingSummary?.add(transaction);
      }
    });

    // Extract the map entries (month as key, MonthlySpendingSummary as value)
    final sortedEntries = monthlySummaries.entries.toList();

    // Sort the entries by the month key in descending order
    sortedEntries.sort((a, b) => b.key.compareTo(a.key));

    // Convert the sorted entries back to a list of MonthlySpendingSummary
    return sortedEntries.map((entry) => entry.value).toList();
  }
}
