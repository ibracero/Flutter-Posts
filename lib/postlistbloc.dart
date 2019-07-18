import 'dart:async';

import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/model/post_model.dart';

class PostListBloc {
  PostListBloc(this._repository);

  final Repository _repository;

  final _postStreamController = StreamController<PostListViewState>();

  Stream<PostListViewState> get posts => _postStreamController.stream;

  void loadPosts() {
    _postStreamController.sink.add(PostListViewState._loading());
    _repository.getPosts().then((posts) {
      if (posts != null && posts.posts.isNotEmpty) {
        _postStreamController.sink.add(PostListViewState._postData(posts));
      } else {
        _postStreamController.sink.add(PostListViewState._error());
      }
    });
  }

  void dispose() {
    _postStreamController.close();
  }
}

class PostListViewState {
  PostListViewState();

  factory PostListViewState._postData(PostModelList posts) = PostListDataState;

  factory PostListViewState._loading() = PostListLoadingState;

  factory PostListViewState._error() = PostListErrorState;
}

class PostListLoadingState extends PostListViewState {}

class PostListDataState extends PostListViewState {
  PostListDataState(this.posts);

  final PostModelList posts;
}

class PostListErrorState extends PostListViewState {}
