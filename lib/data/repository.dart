import 'dart:async';
import 'package:flutter_posts/data/network/post_api_service.dart';
import 'package:flutter_posts/model/post_model.dart';
import 'package:flutter_posts/data/local/database.dart';
import 'package:connectivity/connectivity.dart';

class Repository {
  Future<PostModelList> getPosts() async {
    PostModelList posts = PostModelList();
    ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      posts = await DatabaseHelper.db.getPosts();
    } else {
      posts = await PostApiService().getPosts();
      DatabaseHelper.db.insertOrUpdate(posts);
    }

    return posts;
  }

  Future<PostModel> getPost(int postId) async {
    return await DatabaseHelper.db.getPost(postId);
  }
}
