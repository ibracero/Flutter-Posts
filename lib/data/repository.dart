import 'package:flutter_posts/data/network/post_api_service.dart';
import 'package:flutter_posts/model/post_model.dart';

class Repository {
  Future<PostModelList> getPosts() async {
    return PostApiService().getPosts();
  }
}