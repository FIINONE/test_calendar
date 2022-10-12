import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:task_calendar/data/models/data_model.dart';
import 'package:task_calendar/data/models/day_model.dart';
import 'package:task_calendar/data/providers/data_provider.dart';
import 'package:task_calendar/data/repo/data_repo.dart';
import 'package:task_calendar/ui/widgets/day_widget.dart';
import 'package:task_calendar/ui/widgets/weekday_panel.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final data = DataRepo(DataProvider());

  int _sweetchWeekDay(int year, int month, int index) {
    return DateTime(year, month, index + 1).weekday - 1;
  }

  DayType _getColor(DataModel model, int day) {
    for (var element in model.green) {
      if (element == day) return DayType.green;
    }

    for (var element in model.grey) {
      if (element == day) return DayType.grey;
    }

    for (var element in model.yellow) {
      if (element == day) return DayType.yellow;
    }
    return DayType.white;
  }

  List<DayModel> _generateDays(int daysINMonth, int year, int month, DataModel data) {
    final dayList = List.generate(
      daysINMonth,
      (index) => DayModel(
        weekDay: WeekDay.values[_sweetchWeekDay(year, month, index)],
        dayType: _getColor(data, index + 1),
        day: index + 1,
      ),
    );

    final daysEmpty =
        List.generate(dayList.first.weekDay!.index, (index) => DayModel(weekDay: null, day: 0, dayType: DayType.white));
    dayList.insertAll(0, daysEmpty);

    return dayList;
  }

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientationISPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final padding = orientationISPortrait ? 16.0 : 36.0;

    final width = orientationISPortrait ? size.width : size.height;
    final boxWidth = (width - 12 * 7 - (padding * 2)) / 7;
    final double paddingBetwwen = orientationISPortrait ? 12 : (size.width - 36 - boxWidth * 7) / 7;

    return Scaffold(
      body: FutureBuilder<DataModel?>(
        future: data.getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final date = snapshot.data!.date;
          final daysINMonth = DateTime(date.year, date.month + 1, 0).day;
          final dayList = _generateDays(daysINMonth, date.year, date.month, snapshot.data!);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WeekDayPanel(paddingBetwwen: paddingBetwwen, boxWidth: boxWidth),
                MonthBuilder(
                  paddingBetwwen: paddingBetwwen,
                  dayList: dayList,
                  boxWidth: boxWidth,
                  year: date.year,
                  month: date.month,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MonthBuilder extends StatelessWidget {
  const MonthBuilder({
    Key? key,
    required this.paddingBetwwen,
    required this.dayList,
    required this.boxWidth,
    required this.year,
    required this.month,
  }) : super(key: key);

  final double paddingBetwwen;
  final List<DayModel> dayList;
  final double boxWidth;
  final int year;
  final int month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Wrap(
        spacing: paddingBetwwen,
        runSpacing: 8,
        children: dayList
            .map(
              (day) => day.weekDay != null
                  ? DayWidget(
                      boxWidth: boxWidth,
                      day: day,
                      year: year,
                      month: month,
                    )
                  : SizedBox(
                      height: boxWidth,
                      width: boxWidth,
                    ),
            )
            .toList(),
      ),
    );
  }
}
