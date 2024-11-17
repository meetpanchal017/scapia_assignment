part of '../screens/spending_details_screen.dart';

class _TransactionPrefix extends StatelessWidget {

  const _TransactionPrefix({
    required this.type,
  });
  final TransactionType? type;

  IconData? get transactionIcon {
    if (type == TransactionType.credit) {
      return Icons.arrow_downward_outlined;
    } else if (type == TransactionType.debit) {
      return Icons.arrow_upward_outlined;
    }
    return null;
  }

  Color? get iconColor {
    if (type == TransactionType.credit) {
      return Colors.green;
    } else if (type == TransactionType.debit) {
      return Colors.red;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (type != null) {
      return Transform.rotate(
        angle: pi * 0.25, // Rotate by 90 degrees in radians
        child: Icon(
          transactionIcon,
          color: iconColor,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
