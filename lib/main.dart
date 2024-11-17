import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia_assignment/features/presentation/my_spending/blocs/card_summary_bloc/card_summary_bloc.dart';
import 'package:scapia_assignment/features/presentation/my_spending/screens/my_spending_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CardSummaryBloc(),
        child: const MySpendingScreen(),
      ),
    );
  }
}
