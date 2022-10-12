class DayModel {
  final WeekDay? weekDay;
  final DayType dayType;
  final int day;

  DayModel({
    required this.weekDay,
    required this.day,
    required this.dayType,
  });
}

enum WeekDay { Mon, Tue, Wen, Thu, Fri, Sat, Sun }

enum DayType { green, yellow, grey, white }
