// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

List<CommentsModel> commentsModelFromJson(String str) =>
    List<CommentsModel>.from(
        json.decode(str).map((x) => CommentsModel.fromJson(x)));

String commentsModelToJson(List<CommentsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsModel {
  CommentsModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
