import 'package:flutter/material.dart';
import 'package:task_calendar/common/app_colors.dart';
import 'package:task_calendar/data/models/day_model.dart';

class WeekDayPanel extends StatelessWidget {
  const WeekDayPanel({
    Key? key,
    required this.paddingBetwwen,
    required this.boxWidth,
  }) : super(key: key);

  final double paddingBetwwen;
  final double boxWidth;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: paddingBetwwen,
      children: WeekDay.values
          .map((day) => SizedBox(
                width: boxWidth,
                child: Text(
                  day.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: day == WeekDay.Sun ? AppColors.red : AppColors.greyBlack),
                ),
              ))
          .toList(),
    );
  }
}
