import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/model/post_model.dart';
import 'package:flutter_posts/postbloc.dart';

class PostListScreen extends StatefulWidget {
  PostListScreen(this._repository);

  final Repository _repository;

  @override
  State<StatefulWidget> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  PostBloc _postBloc;

  @override
  void initState() {
    _postBloc = PostBloc(widget._repository);
    _postBloc.loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: SafeArea(
        child: StreamBuilder<PostsViewState>(
            stream: _postBloc.posts,
            initialData: PostsLoadingState(),
            builder: (context, snapshot) {
              if (snapshot.data is PostsLoadingState) {
                return _buildLoading();
              }
              if (snapshot.data is PostsDataState) {
                return _buildContent(snapshot.data);
              }
            }),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(PostsDataState data) {
    PostModelList _postList = data.posts;

    return Container(
      child: ListView.builder(itemBuilder: (context, position) {
        return Card(
          child: Text(_postList.posts[position].body),
        );
      }),
    );
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }
}
