import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpFetch {
  HttpFetch(this.url);
  String url;

  getHttpRequest() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print("this is the jsonResponse: $jsonResponse ");
      return jsonResponse;
    } else
      print("this is the statusCode: $response.statusCode");
    return response.statusCode;
  }
}
