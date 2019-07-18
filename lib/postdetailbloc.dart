import 'dart:async';

import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/model/post_model.dart';

class PostDetailsBloc {
  PostDetailsBloc(this._repository);

  final Repository _repository;

  final _postStreamController = StreamController<PostDetailsViewState>();

  Stream<PostDetailsViewState> get post => _postStreamController.stream;

  void getPost(int postId) {
    _repository.getPost(postId).then((post) {
      if (post != null) {
        _postStreamController.sink.add(PostDetailsViewState._postData(post));
      } else {
        _postStreamController.sink.add(PostDetailsViewState._error());
      }
    });
  }

  void dispose() {
    _postStreamController.close();
  }
}

class PostDetailsViewState {
  PostDetailsViewState();

  factory PostDetailsViewState._postData(PostModel post) = PostDetailsDataState;

  factory PostDetailsViewState._error() = PostDetailsErrorState;
}

class PostsLoadingState extends PostDetailsViewState {}

class PostDetailsDataState extends PostDetailsViewState {
  PostDetailsDataState(this.postDetails);

  final PostModel postDetails;
}

class PostDetailsErrorState extends PostDetailsViewState {}
