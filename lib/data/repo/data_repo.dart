import 'dart:convert';

import 'package:task_calendar/data/models/data_model.dart';
import 'package:task_calendar/data/providers/data_provider.dart';

class DataRepo {
  final DataProvider _provider;

  DataRepo(this._provider);

  Future<DataModel?> getData() async {
    final stream = await _provider.getData();

    DataModel? model;
    final sub = stream.listen((json) {
      print(json);
      final map = jsonDecode(json);
      model = DataModel.fromMap(map);
    });

    await sub.asFuture();

    return model;
  }
}
