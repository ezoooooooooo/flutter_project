import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static Future<dynamic> fetchApartments() async {
    var response = await http.get(Uri.parse('http://localhost:3000/api/apartments'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch apartments');
    }
  }
}
