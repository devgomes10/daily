import 'dart:convert';
import 'package:daily/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import '../models/journal.dart';

class JournalService {
  static const String url = "http://192.168.15.5:3000/";
  static const String resource = "journals/";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  String getUrl() {
    return "$url$resource";
  }

  Future<bool> register(Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {'Content-type': 'application/json'},
      body: jsonJournal,
    );

    //create with success = true
    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(Uri.parse(getUrl()));

    if (response.statusCode != 200) {
      throw Exception();
    }

    List<Journal> list = [];

    List<dynamic> dynamicList = json.decode(response.body);

    for (var jsonMap in dynamicList) {
      list.add(Journal.fromMap(jsonMap));
    }

    return list;
  }
}
