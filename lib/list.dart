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
                return _buildListView(snapshot.data);
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

  Widget _buildListView(PostsDataState data) {
    PostModelList _postList = data.posts;

    return ListView.builder(itemBuilder: (context, position) {
      return _buildListViewItem(_postList.posts[position]);
    });
  }

  Widget _buildListViewItem(PostModel post) {
    return Card(
        child: new Row(
      children: [
        Padding(padding: EdgeInsets.all(16), child: getAvatar(post)),
        Expanded(
            child: new Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 16, 8),
                child: Text(
                  post.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 16, 8),
                child: Text(
                  post.body,
                  textAlign: TextAlign.left,
                ))
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ))
      ],
    ));
  }

  Image getAvatar(PostModel post) {
    return Image.network("https://api.adorable.io/avatars/50/${post.userId}");
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }
}
