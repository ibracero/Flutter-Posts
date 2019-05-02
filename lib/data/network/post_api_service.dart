import 'dart:async';
import 'dart:convert';

import 'package:flutter_posts/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostApiService {
  PostApiService();

  String url = 'https://jsonplaceholder.typicode.com/posts';

  Future<PostModelList> getPosts() async {
    final response = await http.get('$url');
    final jsonResponse = json.decode(response.body);
    return PostModelList.fromMap(jsonResponse);
  }
}
