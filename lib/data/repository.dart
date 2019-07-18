import 'dart:async';
import 'package:flutter_posts/data/network/post_api_service.dart';
import 'package:flutter_posts/model/post_model.dart';
import 'package:flutter_posts/data/local/database.dart';
import 'package:connectivity/connectivity.dart';

class Repository {
  Future<PostModelList> getPosts() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result != ConnectivityResult.none) {
      PostModelList apiPosts = await PostApiService().getPosts();
      DatabaseHelper.db.insertOrUpdate(apiPosts);
    }

    return await DatabaseHelper.db.getPosts();
  }

  Future<PostModel> getPost(int postId) async {
    return await DatabaseHelper.db.getPost(postId);
  }
}
