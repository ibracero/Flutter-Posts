import 'package:meta/meta.dart';

class PostModel {
  PostModel(
      {@required this.userId,
      @required this.id,
      @required this.title,
      @required this.body});

  final int userId;
  final int id;
  final String title;
  final String body;

  factory PostModel.fromMap(Map<String, dynamic> json) {
    return new PostModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }

  Map<String, dynamic> toMap() {
    return {'user_id': userId, 'id': id, 'title': title, 'body': body};
  }
}

class PostModelList {
  PostModelList({this.posts});

  final List<PostModel> posts;

  factory PostModelList.fromMap(List<dynamic> parsedJson) {
    return new PostModelList(
        posts: parsedJson.map((i) => PostModel.fromMap(i)).toList());
  }
}
