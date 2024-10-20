part of 'card_summary_bloc.dart';

sealed class CardSummaryState {}

final class CardSummaryInitial extends CardSummaryState {}

final class CardSummarySuccessState extends CardSummaryState {
  final double creditCardLimit;
  final List<MonthlySpendingSummary> spendingSummary;

  CardSummarySuccessState({
    required this.creditCardLimit,
    required this.spendingSummary,
  });
}

final class CardSummaryLoadingState extends CardSummaryState {}

final class CardSummaryFailureState extends CardSummaryState {
  final String error;

  CardSummaryFailureState({
    required this.error,
  });
}
