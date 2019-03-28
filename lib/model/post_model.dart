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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return new PostModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}

class PostModelList {
  PostModelList({this.posts});

  final List<PostModel> posts;

  factory PostModelList.fromJson(List<dynamic> parsedJson) {
    return new PostModelList(
        posts: parsedJson.map((i) => PostModel.fromJson(i)).toList());
  }
}
