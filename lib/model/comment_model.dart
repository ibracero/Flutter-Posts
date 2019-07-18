import 'package:meta/meta.dart';

class CommentModel {
  CommentModel({
    @required this.postId,
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.body
  });

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  factory CommentModel.fromMap(Map<String, dynamic> json) {
    return new CommentModel(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body
    };
  }
}

class CommentModelList {
  CommentModelList({this.comments});

  final List<CommentModel> comments;

  factory CommentModelList.fromMap(List<dynamic> parsedJson){
    return new CommentModelList(
        comments: parsedJson.map((i) => CommentModel.fromMap(i)).toList());
  }
}