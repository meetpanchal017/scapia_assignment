part of 'monthly_spending_heat_chart.dart';

class _WeekHeader extends StatelessWidget {
  const _WeekHeader();

  @override
  Widget build(BuildContext context) {
    final config = ConfigurationProvider.of(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: config.padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: config.weekHeaderCellAspectRatio,
        crossAxisSpacing: config.cellHorizontalSpacing,
        mainAxisSpacing: config.cellVerticalSpacing,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            DayMonthUtils.getWeekDayByNumber(++index),
            style: config.weekHeaderTextStyle ?? context.textTheme.labelLarge,
          ),
        );
      },
    );
  }
}
