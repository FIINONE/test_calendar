import 'package:task_calendar/data/models/date_model.dart';

class DataModel {
  final DateModel date;
  final List<int> green;
  final List<int> yellow;
  final List<int> grey;

  DataModel({
    required this.date,
    required this.green,
    required this.yellow,
    required this.grey,
  });

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      date: _getDate(map['date']),
      green: _stringToInt(List<String>.from(map['green'])),
      yellow: _stringToInt(List<String>.from(map['yellow'])),
      grey: _stringToInt(List<String>.from(map['grey'])),
    );
  }

  static DateModel _getDate(String date) {
    final splitedDate = date.split('.');
    final monthStr = splitedDate[0];
    final yearStr = splitedDate[1];

    final month = int.parse(monthStr);
    final year = int.parse(yearStr);

    return DateModel(month: month, year: year);
  }

  static List<int> _stringToInt(List<String> listStr) {
    return listStr.map((str) => int.parse(str)).toList();
  }
}
