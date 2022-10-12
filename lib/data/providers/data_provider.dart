import 'dart:convert';
import 'dart:io';

import 'package:task_calendar/data/models/data_model.dart';

class DataProvider {
  Future<Stream<String>> getData() async {
    final client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final uri = Uri.parse('https://www.jsonkeeper.com/b/JZON');
    final request = await client.getUrl(uri);
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final response = await request.close();

    final stream = response.transform(utf8.decoder);

    return stream;
  }
}
