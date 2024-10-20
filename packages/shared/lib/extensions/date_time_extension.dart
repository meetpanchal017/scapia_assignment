import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get getFormattedDateByMonth {
    DateFormat format = DateFormat.yMMMMd();
    return format.format(this);
  }

  bool get isCurrentMonth {
    final DateTime now = DateTime.now();

    // Create DateTime objects with just year, month, and day (ignoring the time)
    final DateTime currentDate = DateTime(now.year, now.month);
    final DateTime inputDate = DateTime(year, month);

    return inputDate.isAtSameMomentAs(currentDate);
  }

  bool get isUpComingDay {
    final DateTime now = DateTime.now();

    // Create DateTime objects with just year, month, and day (ignoring the time)
    final DateTime currentDate = DateTime(now.year, now.month, now.day);
    final DateTime inputDate = DateTime(year, month, day);

    return inputDate.isAfter(currentDate
    );
  }
}
