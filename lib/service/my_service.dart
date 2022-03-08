import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_zadaniya/model/user_model.dart';

class UserService {
  static Future<List<UserModel>> getUserService() async {
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    dynamic response = await http.get(url);
    response = jsonDecode(response.body);
    return (response as List).map((e) => UserModel.fromJson(e)).toList();
  }
}
