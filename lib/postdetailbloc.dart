import 'dart:async';

import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/model/comment_model.dart';

class PostDetailsBloc {
  PostDetailsBloc(this._repository);

  final Repository _repository;

  final _postStreamController = StreamController<PostDetailsViewState>();

  Stream<PostDetailsViewState> get comments => _postStreamController.stream;

  void getComments(int postId) {
    _repository.getComments(postId).then((comments) {
      if (comments != null) {
        _postStreamController.sink
            .add(PostDetailsViewState._commentsData(comments));
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

  factory PostDetailsViewState._commentsData(CommentModelList comments) =
      PostDetailsDataState;

  factory PostDetailsViewState._loading() = PostDetailsLoadingState;

  factory PostDetailsViewState._error() = PostDetailsErrorState;
}

class PostDetailsLoadingState extends PostDetailsViewState {}

class PostDetailsDataState extends PostDetailsViewState {
  PostDetailsDataState(this.comments);

  final CommentModelList comments;
}

class PostDetailsErrorState extends PostDetailsViewState {}
