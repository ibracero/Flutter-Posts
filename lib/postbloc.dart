import 'dart:async';

import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/model/post_model.dart';

class PostBloc {
  PostBloc(this._repository);

  final Repository _repository;

  final _postStreamController = StreamController<PostsViewState>();

  Stream<PostsViewState> get posts => _postStreamController.stream;

  void loadPosts() {
    _postStreamController.sink.add(PostsViewState._loading());
    _repository.getPosts().then(posts){
      _postStreamController.sink.add(PostState._postData(posts))
    }
  }

  void dispose() {
    _postStreamController.close();
  }
}

class PostsViewState {
  PostsViewState();

  factory PostsViewState._postData(List<PostModel> posts) = PostsDataState;

  factory PostsViewState._loading() = PostsLoadingState;
}

class PostsInitState extends PostsViewState {}

class PostsLoadingState extends PostsViewState {}

class PostsDataState extends PostsViewState {
  PostsDataState(this.posts);

  final List<PostModel> posts;
}
