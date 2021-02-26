import 'dart:convert';

import 'package:jelajah/api/api.dart';
import 'package:jelajah/model/peopleModel.dart';

class PeopleView {
  static List<People> people;

  static Future loadLogs() async {
    try {
      var response = await CallApi().getData("people");
      //print(response.body);
      if (response.statusCode == 200) {
        people = List<People>();
        var parsedJson = json.decode(response.body);
        parsedJson['data'].forEach((api) {
          people.add(People.fromJson(api));
        });

        return people;
      } else {
        throw Exception('Failed to load ');
      }
    } catch (e) {
      print(e);
    }
  }
}
