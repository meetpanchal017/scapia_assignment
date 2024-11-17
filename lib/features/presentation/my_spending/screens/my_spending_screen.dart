import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia_assignment/core/widgets/loading_indicator.dart';
import 'package:scapia_assignment/features/presentation/my_spending/blocs/card_summary_bloc/card_summary_bloc.dart';
import 'package:scapia_assignment/features/presentation/my_spending/screens/spending_details_screen.dart';
import 'package:shared/extensions/date_time_extension.dart';
import 'package:spending_heatmap_chart/spending_heatmap_chart.dart';

class MySpendingScreen extends StatefulWidget {
  const MySpendingScreen({super.key});

  @override
  State<MySpendingScreen> createState() => _MySpendingScreenState();
}

class _MySpendingScreenState extends State<MySpendingScreen> {
  late final CardSummaryBloc transactionBloc;

  @override
  void initState() {
    super.initState();
    transactionBloc = context.read<CardSummaryBloc>()
      ..add(GetAllTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Spending'),
      ),
      body: SafeArea(
        child: BlocBuilder(
          bloc: transactionBloc,
          builder: (context, state) {
            if (state is CardSummaryLoadingState) {
              return const LoadingIndicator();
            } else if (state is CardSummaryFailureState) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is CardSummarySuccessState) {
              final spendingSummary = state.spendingSummary;
              final config = HeatMapChartConfiguration(
                maximumSpendingLimit: state.creditCardLimit,
              );
              return Column(
                children: [
                  const SizedBox(height: 8),
                  SpendingLegends(
                    config: config,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      itemCount: spendingSummary.length,
                      itemBuilder: (context, index) {
                        return MonthlySpendingHeatChart(
                          config: config,
                          monthlySummary: spendingSummary[index],
                          onCellTapped: (dailySummary) {
                            if (dailySummary.date?.isUpComingDay ?? false) {
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute<MySpendingScreen>(
                                builder: (context) => SpendingDetailsScreen(
                                  spendingSummary: dailySummary,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
