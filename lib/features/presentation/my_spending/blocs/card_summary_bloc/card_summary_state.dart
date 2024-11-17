part of 'card_summary_bloc.dart';

sealed class CardSummaryState {}

final class CardSummaryInitial extends CardSummaryState {}

final class CardSummarySuccessState extends CardSummaryState {

  CardSummarySuccessState({
    required this.creditCardLimit,
    required this.spendingSummary,
  });
  final double creditCardLimit;
  final List<MonthlySpendingSummary> spendingSummary;
}

final class CardSummaryLoadingState extends CardSummaryState {}

final class CardSummaryFailureState extends CardSummaryState {

  CardSummaryFailureState({
    required this.error,
  });
  final String error;
}
