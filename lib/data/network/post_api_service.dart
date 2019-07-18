import 'dart:async';
import 'dart:convert';

import 'package:flutter_posts/model/post_model.dart';
import 'package:flutter_posts/model/comment_model.dart';
import 'package:http/http.dart' as http;

class PostApiService {
  PostApiService();

  static const String BASE_URL = "https://jsonplaceholder.typicode.com/";
  static const String POSTS_ENDPOINT = "posts";
  static const String COMMENTS_ENDPOINT = "comments";

  Future<PostModelList> getPosts() async {
    final response = await http.get(BASE_URL + POSTS_ENDPOINT);
    final jsonResponse = json.decode(response.body);
    return PostModelList.fromMap(jsonResponse);
  }

  Future<CommentModelList> getComments(int postId) async {
    final response =
        await http.get(BASE_URL + COMMENTS_ENDPOINT + "?postId=$postId");
    final jsonResponse = json.decode(response.body);
    return CommentModelList.fromMap(jsonResponse);
  }
}
