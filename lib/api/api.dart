import 'dart:convert';
import 'package:http/http.dart' as http;

// New Class call API
class CallApi {
  final String _url = 'http://192.168.1.6/jelajah/public/api/';

  // POST method
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      fullUrl,
      body: data,
    );
  }

  // GET method
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(
      fullUrl,
    );
  }
}
