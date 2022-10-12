import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_calendar/common/app_colors.dart';
import 'package:task_calendar/data/models/day_model.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
    Key? key,
    required this.boxWidth,
    required this.day,
    required this.year,
    required this.month,
  }) : super(key: key);

  final double boxWidth;
  final DayModel day;
  final int year;
  final int month;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (day.dayType == DayType.white) {
          return;
        }

        final date = DateTime(year, month, day.day);
        final format = DateFormat('d EEEE y', 'uz');
        final dateFormatted = format.format(date);

        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              contentPadding: const EdgeInsets.all(36),
              children: [
                Text(
                  'Rang: ${_translateColor(day.dayType)}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Sana: $dateFormatted',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(80),
      child: Ink(
        width: boxWidth,
        height: boxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: _setBackgroundColor(day),
        ),
        child: Center(
          child: Text(
            day.day.toString(),
            style: TextStyle(
              fontSize: 14,
              color: _setTextColor(day),
            ),
          ),
        ),
      ),
    );
  }

  Color _setBackgroundColor(DayModel model) {
    switch (model.dayType) {
      case DayType.green:
        return AppColors.green;
      case DayType.yellow:
        return AppColors.yellow;
      case DayType.grey:
        return AppColors.grey;
      case DayType.white:
        return Colors.transparent;
    }
  }

  Color _setTextColor(DayModel model) {
    if (model.weekDay == WeekDay.Sun) return AppColors.red;

    if (model.dayType == DayType.yellow || model.dayType == DayType.green) return Colors.white;

    return Colors.black;
  }

  String _translateColor(DayType dayType) {
    switch (dayType) {
      case DayType.green:
        return 'yashil';
      case DayType.yellow:
        return 'sariq';
      case DayType.grey:
        return 'kulrang';
      case DayType.white:
        return 'oq';
    }
  }
}
