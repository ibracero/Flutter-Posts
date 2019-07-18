import 'package:flutter/material.dart';
import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/model/post_model.dart';
import 'package:flutter_posts/postlistbloc.dart';
import 'package:flutter_posts/widget/detail.dart';

class PostListScreen extends StatefulWidget {
  PostListScreen(this._repository);

  final Repository _repository;

  @override
  State<StatefulWidget> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  PostListBloc _postBloc;

  @override
  void initState() {
    _postBloc = PostListBloc(widget._repository);
    _postBloc.loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: SafeArea(
        child: StreamBuilder<PostListViewState>(
            stream: _postBloc.posts,
            initialData: PostListLoadingState(),
            builder: (context, snapshot) {
              if (snapshot.data is PostListLoadingState) {
                return _buildLoading();
              }
              if (snapshot.data is PostListDataState) {
                return _buildListView(snapshot.data);
              }
              if (snapshot.data is PostListErrorState) {
                return _buildError();
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

  Widget _buildListView(PostListDataState data) {
    PostModelList _postList = data.posts;

    return ListView.builder(itemBuilder: (context, position) {
      return _buildListViewItem(_postList.posts[position]);
    });
  }

  Widget _buildError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Something bad happened!",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
        ),
        Center(
          child: new RaisedButton(
              padding: const EdgeInsets.all(16.0),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: _postBloc.loadPosts,
              child: new Text("Tap to retry")),
        ),
      ],
    );
  }

  Widget _buildListViewItem(PostModel post) {
    return new Card(
        child: new InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        PostDetailScreen(widget._repository, post.id))),
            child: new Row(
              children: [
                Padding(padding: EdgeInsets.all(16), child: getAvatar(post)),
                Expanded(
                    child: new Column(
                  children: [getTitle(post), getBody(post)],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ))
              ],
            )));
  }

  Hero getAvatar(PostModel post) {
    return Hero(
        tag: post.id,
        child: ClipOval(
            child: Image.network(
                "https://api.adorable.io/avatars/60/${post.userId}")));
  }

  Hero getTitle(PostModel post) {
    return Hero(
        tag: "${post.id}title",
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 16, 8),
            child: Material(
                child: Text(
              post.title,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ))));
  }

  Hero getBody(PostModel post) {
    return Hero(
        tag: "${post.id}body",
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16, 8),
            child: Material(
                child: Text(
              post.body,
              textAlign: TextAlign.left,
            ))));
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }
}
