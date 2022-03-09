import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_zadaniya/model/post_model.dart';

class PostService {
  static Future<CommentsModel> postComment(
      String title, String email, String comments) async {
    final Uri apiUrl = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await http.post(apiUrl, body: {
      "name": title,
      "email": email,
      "body": comments,
    });
    var res = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return CommentsModel.fromJson(res);
    } else {
      return null!;
    }
  }
}
