import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<http.Response> get(Uri uri) async {
    return await http.get(uri);
  }
}
